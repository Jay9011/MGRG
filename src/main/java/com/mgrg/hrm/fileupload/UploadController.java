package com.mgrg.hrm.fileupload;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mgrg.hrm.login.C;


@Controller
@RequestMapping("/upload")
public class UploadController {

	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
//	@Autowired
//	@Qualifier("uploadPath")
//	private String uploadPath;
	
	public static String uploadPath = "C:\\SpringUploadRepo\\upload";
	
	@GetMapping("/uploadForm")
	public String uploadForm() {
		return "thymeleaf/upload/uploadForm";
	}
	public static String uploadFile2(String originalName, byte[] fileData) throws Exception {
		
		//겹쳐지지 않는 파일명을 위한 유니크한 값 생성
		UUID uid = UUID.randomUUID();
		//원본파일 이름과 UUID 결합
//		String savedName = uid.toString() + "_" + originalName;
		String savedName = originalName;
		
		
		//저장할 파일준비
		File target = new File(uploadPath, savedName);
		//파일을 저장
		FileCopyUtils.copy(fileData, target);
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		String uploadedFileName = null;
		//파일의 확장자에 따라 썸네일(이미지일경우) 또는 아이콘을 생성함.
		if(MediaUtils.getMediaType(formatName) != null) {
			uploadedFileName = makeThumbnail(savedName);
		}else {
			uploadedFileName = makeIcon(savedName);
		}
		
		//uploadedFileName는 썸네일명으로 화면에 전달된다.
		return uploadedFileName;
	}//
	
	//Post 방식 파일 업로드
	@RequestMapping(value = "/uploadForm", method = RequestMethod.POST)
	public String uploadFormPOST(MultipartFile file, HttpServletResponse response,
			@RequestParam("title")String title, @RequestParam("content")String content) throws Exception {
		IDocDAO dao = C.sqlSession.getMapper(IDocDAO.class);
		logger.info("uploadFormPost");
		
		if(file != null) {
			logger.info("originalName:" + file.getOriginalFilename());
			logger.info("size:" + file.getSize());
			logger.info("ContentType:" + file.getContentType());
		}
		System.out.println(FilenameUtils.getBaseName(file.getOriginalFilename()));
		dao.insert(title, content, file.getOriginalFilename()); //이거는 뒤에 png(확장자) 까지
//		dao.insert(title, content, FilenameUtils.getBaseName(file.getOriginalFilename()));  //뒤에 확장자 명 제거
		
		
		String savedName = uploadFile2(file.getOriginalFilename(), file.getBytes());
		System.out.println(savedName);
		response.sendRedirect("doclist");
		return "login/adminMainPage2";
	}
	
	
	@GetMapping("/doclist")
	public String golist(Model model) {
		
		IDocDAO dao = C.sqlSession.getMapper(IDocDAO.class);
		List<docDTO> dto = dao.select();
		model.addAttribute("list", dto);
		
		return "thymeleaf/upload/doclist";
	}
	
	@RequestMapping(value = "/down")
    public void fileDownload(HttpServletRequest request,HttpServletResponse response) throws Exception {
        //String path =  request.getSession().getServletContext().getRealPath("저장경로");
        
        String filename =request.getParameter("fileName");
        String realFilename="";
        System.out.println(filename);
         
        
        realFilename = uploadPath +"\\"+ filename;
        System.out.println(realFilename);
        File file1 = new File(realFilename);
        if (!file1.exists()) {
            return ;
        }
         
        // 파일명 지정        
        response.setContentType("application/octer-stream");
        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realFilename);
 
            int ncount = 0;
            byte[] bytes = new byte[1024];
 
            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            fis.close();
            os.close();
        } catch (Exception e) {
            System.out.println("FileNotFoundException : " + e);
        }
    }
	
	
	
	
	@GetMapping("/uploadAjax")
	public String goajax() {
		return "thymeleaf/upload/uploadAjax";
	}
	
	
	//Ajax 파일 업로드 produces는 한국어를 정상적으로 전송하기 위한 속성
	@RequestMapping(value="/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjaxPOST(MultipartFile file) throws Exception {
		
		logger.info("originalName:" + file.getOriginalFilename());
		logger.info("size:" + file.getSize());
		logger.info("contentType:" + file.getContentType());
		
		//HttpStatus.CREATED : 리소스가 정상적으로 생성되었다는 상태코드.
		//return new ResponseEntity<>(file.getOriginalFilename(), HttpStatus.CREATED);
		return new ResponseEntity<>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
	}
	
	//화면에 저장된 파일을 보여주는 컨트롤러 /년/월/일/파일명 형태로 입력 받는다.
	// displayFile?fileName=/년/월/일/파일명
	@ResponseBody
	@RequestMapping(value="/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		logger.info("File name: " + fileName);
		
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(uploadPath + fileName);
			if(mType != null) {
				headers.setContentType(mType);
			}else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}// else
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		
		return entity;
	}// displayFile
	
	
	//업로드된 파일 삭제 처리
	@ResponseBody
	@RequestMapping(value="/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) throws Exception {
		
		logger.info("delete file:" + fileName);
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		if(mType != null) {
			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			new File(uploadPath + (front+end).replace('/', File.separatorChar)).delete();
		}//if
		
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
		/////////////////////////////////////////////////////
	
	
	//음??? 아이콘? 이미지 파일이 아닌경우  썸네일을 대신?
	private static String makeIcon(String fileName) throws Exception{
		String iconName = uploadPath+ File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	//썸네일 이미지 생성
	private static String makeThumbnail(String fileName) throws Exception {
		
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath, fileName));
		
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		String thumbnailName = fileName;
		
		File newFile = new File(uploadPath, thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		ImageIO.write(destImg, formatName, newFile);
		return thumbnailName;
	}
	
	
}

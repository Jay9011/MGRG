package com.mgrg.hrm.excel;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mgrg.hrm.admin.AdminMemDTO;
import com.mgrg.hrm.admin.IAdminDAO;
import com.mgrg.hrm.login.C;

@Controller
public class ExcelController {

	
	@GetMapping("/boardList")
	public String gobobo(Model model) {
		IAdminDAO dao = C.sqlSession.getMapper(IAdminDAO.class);
		List<AdminMemDTO> dto = dao.select();
		model.addAttribute("list", dto);
		
		return "boardList";
	}
	
	
	@RequestMapping(value = "/excelDown.do")

	public void excelDown(HttpServletResponse response, Model model, HttpServletRequest request) throws Exception {
		IAdminDAO dao = C.sqlSession.getMapper(IAdminDAO.class);
		List<AdminMemDTO> dto = dao.select();
		model.addAttribute("list", dto);


	    // 게시판 목록조회

	    //List<BoardVO> list = boardService.selectBoardList();



	    // 워크북 생성

	    Workbook wb = new HSSFWorkbook();

	    Sheet sheet = wb.createSheet("게시판");

	    Row row = null;

	    Cell cell = null;

	    int rowNo = 0;



	    // 테이블 헤더용 스타일

	    CellStyle headStyle = wb.createCellStyle();

	    // 가는 경계선을 가집니다.

	    headStyle.setBorderTop(BorderStyle.THIN);

	    headStyle.setBorderBottom(BorderStyle.THIN);

	    headStyle.setBorderLeft(BorderStyle.THIN);

	    headStyle.setBorderRight(BorderStyle.THIN);



	    // 배경색은 노란색입니다.

	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());

	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);



	    // 데이터는 가운데 정렬합니다.

	    headStyle.setAlignment(HorizontalAlignment.CENTER);



	    // 데이터용 경계 스타일 테두리만 지정

	    CellStyle bodyStyle = wb.createCellStyle();

	    bodyStyle.setBorderTop(BorderStyle.THIN);

	    bodyStyle.setBorderBottom(BorderStyle.THIN);

	    bodyStyle.setBorderLeft(BorderStyle.THIN);

	    bodyStyle.setBorderRight(BorderStyle.THIN);



	    // 헤더 생성

	    row = sheet.createRow(rowNo++);

	    cell = row.createCell(0);

	    cell.setCellStyle(headStyle);

	    cell.setCellValue("직원 번호");

	    cell = row.createCell(1);

	    cell.setCellStyle(headStyle);

	    cell.setCellValue("이름");

	    cell = row.createCell(2);

	    cell.setCellStyle(headStyle);

	    cell.setCellValue("직책");

	    cell = row.createCell(3);

	    cell.setCellStyle(headStyle);

	    cell.setCellValue("연봉");
	    
	    cell = row.createCell(4);

	    cell.setCellStyle(headStyle);

	    cell.setCellValue("생년월일");

	    // 데이터 부분 생성

	    for(AdminMemDTO vo : dto) {

	        row = sheet.createRow(rowNo++);

	        cell = row.createCell(0);

	        cell.setCellStyle(bodyStyle);

	        cell.setCellValue(vo.getUid());

	        cell = row.createCell(1);

	        cell.setCellStyle(bodyStyle);

	        cell.setCellValue(vo.getName());

	        cell = row.createCell(2);

	        cell.setCellStyle(bodyStyle);

	        cell.setCellValue(vo.getPosition());
	        
	        cell = row.createCell(3);
	        
	        cell.setCellStyle(bodyStyle);
	        
	        cell.setCellValue(vo.getSalary());
	        
	        cell = row.createCell(4);
	        
	        cell.setCellStyle(bodyStyle);
	        
	        cell.setCellValue(vo.getBirth());

	    }


	    // 컨텐츠 타입과 파일명 지정

	    response.setContentType("ms-vnd/excel");

	    response.setHeader("Content-Disposition", "attachment;filename=test.xls");



	    // 엑셀 출력

	    wb.write(response.getOutputStream());

	    wb.close();

	}

	

}

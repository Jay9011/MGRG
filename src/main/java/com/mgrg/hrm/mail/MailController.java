package com.mgrg.hrm.mail;

import java.io.PrintWriter;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mgrg.hrm.login.C;
import com.mgrg.hrm.login.ILoginDAO;
import com.mgrg.hrm.login.ValiDTO;

@Controller
public class MailController {

	@Autowired
	private JavaMailSender mailSender;

	@GetMapping("/mailgo")
	public String mailgo() {
		return "login/mailTest";
	}
	
	
	// mailSending 코드
	@RequestMapping(value = "/mailSending")
	public String mailSending(HttpServletRequest request, HttpServletResponse response,Model model) throws Exception{
		
		String setfrom = "ddnd194@naver.com";  //진짜 메일주소를 입력해야함 ^^
		String tomail = request.getParameter("tomail"); // 받는 사람 이메일
		String title = request.getParameter("title"); // 제목
		String id = request.getParameter("findid");

		
		ILoginDAO dao2 = C.sqlSession.getMapper(ILoginDAO.class);
		ValiDTO dto = dao2.vali(tomail, id);
		if(dto == null || dto.getPw().equals("") || dto.getPw() == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printWriter = response.getWriter();
			printWriter.println("<script src=\"https://code.jquery.com/jquery-3.5.1.js\"\r\n" + 
					"	integrity=\"sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=\"\r\n" + 
					"	crossorigin=\"anonymous\"></script>");
			printWriter.println("<script type=\"text/javascript\"\r\n" + 
					"	src=\"https://unpkg.com/sweetalert/dist/sweetalert.min.js\"></script>");
			//printWriter.println("<script>alert('존재하지 않는 email, id 입니다.');</script>");
			printWriter.println("<script>\r\n" + 
					"		 $(document).ready(function () {\r\n" + 
					"	            swal({\r\n" + 
					"	                title: '존재하지 않는 Email, ID 입니다.',\r\n" + 
					"	                text: 'Incorrect ID or Email.',\r\n" + 
					"	                icon: 'warning',\r\n" + 
					"	                button:{\r\n" + 
					"	                		text : 'back',\r\n" + 
					"	                		value : true,\r\n" + 
					"	                }\r\n" + 
					"	            }).then((result) => {\r\n" + 
					"	            	if(result){\r\n" + 
					"	            		history.back();\r\n" + 
					"	            	}\r\n" + 
					"	            });\r\n" + 
					"	      });\r\n" + 
					"		</script>");
			printWriter.flush();
			//return "login/mainLoginPage";
		} else {
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message,
						true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(id+"의 비밀번호 => "+dto.getPw()); // 메일 내용

				mailSender.send(message);
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter printWriter = response.getWriter();
				printWriter.println("<script src=\"https://code.jquery.com/jquery-3.5.1.js\"\r\n" + 
						"	integrity=\"sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=\"\r\n" + 
						"	crossorigin=\"anonymous\"></script>");
				printWriter.println("<script type=\"text/javascript\"\r\n" + 
						"	src=\"https://unpkg.com/sweetalert/dist/sweetalert.min.js\"></script>");
				printWriter.println("<script>\r\n" + 
						"		 $(document).ready(function () {\r\n" + 
						"	            swal({\r\n" + 
						"	                title: '성공',\r\n" + 
						"	                text: '메일을 확인해보세요.',\r\n" + 
						"	                icon: 'success',\r\n" + 
						"	                button:{\r\n" + 
						"	                		text : 'back',\r\n" + 
						"	                		value : true,\r\n" + 
						"	                }\r\n" + 
						"	            }).then((result) => {\r\n" + 
						"	            	if(result){\r\n" + 
						"	            		location.href='login/mainLoginPage'\r\n" + 
						"	            	}\r\n" + 
						"	            });\r\n" + 
						"	      });\r\n" + 
						"		</script>");
				printWriter.flush();
				//response.sendRedirect(request.getContextPath()+"/login/mainLoginPage");
			} catch (Exception e) {
				System.out.println(e);
			}
			return "login/mainLoginPage";
		}
		return "login/mainLoginPage";
	}

}

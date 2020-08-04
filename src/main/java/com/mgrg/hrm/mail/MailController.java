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
//				messageHelper.setText(id+"의 비밀번호 => "+dto.getPw()); // 메일 내용
				messageHelper.setText("<div id='readFrame'><table style='margin:0 auto; background-color:#F7F8F8;' width='100%' cellspacing='0' cellpadding='0'><tbody><tr><td height='10'></td></tr><tr><td style='padding:0 10px'><table style='max-width:720px; background-color:#fff; table-layout:fixed; margin:0 auto; word-break:break-all; word-wrap:break-word;' width='100%' cellspacing='0' cellpadding='0'><tbody><tr style='background-color:#6547A6;'><td width='5.6%'></td><td><div style='padding:30px 0 28px 0;'><span style='color: white; font-size: 20px;'>비밀번호 잊지마세요..</span></div></a></td><td width='5.6%'></td></tr ><tr><td width='5.6%'></td><td ><div style='margin:30px 0 0 0;' ><p style='margin:0 0 20px 0; text-align: center;' ><img style='width:500px; height:400px;'src='https://www.repricerexpress.com/wp-content/uploads/2019/07/shutterstock_13308901581.jpg' alt='' ></p ><p style='margin:15px 0 0 0; font-size:14px; line-height:22px; font-weight:normal; color:#111;'> 잊어버리신 비밀번호..</p ><div style='margin-top:30px; padding:25px 20px; border:1px solid #E2E4EE; border-left:0; border-right:0;'> 아이디 : <span style='color: #6547A6; font-size: 1.5em;'>" + id +  "</span><br> 비밀번호 : <span style='color: #6547A6; font-size: 1.5em;'>" + dto.getPw() + "</span ></div ><div style='padding:25px 20px; border-bottom:1px solid #E2E4EE;'> </div ></td><td width='5.6%'></td></tr ><tr><td width='5.6%'></td><td ><div style='margin:60px 0 30px 0' ><p style='margin:0 0 3px 0; font-size:13px; line-height:20px; font-weight:normal; color:#888;'> 본 메일은 발신전용입니다. 궁금한 사항을 문의하시려면 본사에 직접 문의하세요. </p ><p style='margin:0 0 3px 0; font-size:13px; line-height:20px; font-weight:normal; color:#888;'> ⓒ MGRG HRM System </p ></div ></td><td width='5.6%'></td></tr ></tbody></table ></td></tr ><tr><td height='10'></td></tr ></tbody></table ></div>",true); // 메일 내용

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

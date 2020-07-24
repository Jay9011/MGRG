package com.mgrg.hrm.mail;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mgrg.hrm.login.C;
import com.mgrg.hrm.login.ILoginDAO;

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
	public String mailSending(HttpServletRequest request, HttpServletResponse response) {

		String setfrom = "ddnd194@naver.com";  //진짜 메일주소를 입력해야함 ^^
		String tomail = request.getParameter("tomail"); // 받는 사람 이메일
		String title = request.getParameter("title"); // 제목
//		String content = request.getParameter("content"); // 내용

		String id = request.getParameter("findid");
		ILoginDAO dao = C.sqlSession.getMapper(ILoginDAO.class);
		String findpw = dao.findPW(id);
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,
					true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(id+"의 비밀번호 => "+findpw); // 메일 내용

			mailSender.send(message);
			response.sendRedirect(request.getContextPath()+"/login/adminMainPage");
		} catch (Exception e) {
			System.out.println(e);
		}

		return "login/mainLoginPage";
	}

	


	
}

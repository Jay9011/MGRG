package com.mgrg.hrm.mail;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mgrg.hrm.D;

public class MailSendDefault {

	private JavaMailSender mailSender = D.mailSender;

	@RequestMapping("mail/sendmail")
	public int sendMail(String setfrom, String tomail, String title, String content) {

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content, true); // 메일 내용

			mailSender.send(message);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	} // end sendMail()
}

package com.mgrg.hrm;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private SqlSession sqlSession;
	private JavaMailSender mailSender;
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		D.sqlSession = sqlSession;
	} // end setSqlSession()
	@Autowired
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
		D.mailSender = mailSender;
	} // end setMailSender()
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "login/mainLoginPage";
	}
	
	@RequestMapping("/staff")
	public String staff(Model model) {
		return "staff/list";
	} // end staff();
	
	@RequestMapping("/login/mem")
	public String mem(Model model) {
		return "login/mem";
	}
	@RequestMapping("/login/admain")
	public String admain(Model model) {
		return "login/admain";
	}
	@RequestMapping("/notice")
	public String notice(Model model) {
		return "notice/noti";
	}
	@RequestMapping("/holiy")
	public String holiyday(Model model) {
		return "holiy/holiyday";
	}
	@RequestMapping("/changePw")
	public String pwChange(Model model) {
		return "login/pwChange";
	}
}	

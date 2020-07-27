package com.mgrg.hrm;

import org.apache.ibatis.session.SqlSession;
import org.springframework.mail.javamail.JavaMailSender;

public class D {
	/**
	 * MyBatis 용 SQL Session
	 */
	public static SqlSession sqlSession;
	public static JavaMailSender mailSender;
}

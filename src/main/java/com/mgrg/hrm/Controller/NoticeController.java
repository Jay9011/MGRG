package com.mgrg.hrm.Controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mgrg.hrm.D;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	private SqlSession sqlSession;
	@Autowired  
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		D.sqlSession = sqlSession;
	}
	@RequestMapping("/noti")
	public String read() {
		return "notice/noti";
	}
}

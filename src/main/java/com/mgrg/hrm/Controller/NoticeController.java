package com.mgrg.hrm.Controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mgrg.hrm.D;
import com.mgrg.hrm.notice.BoardDTO;

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
	public String read(Model model) {
		model.addAttribute("BoardDTO",new BoardDTO());
		return "notice/noti";
	}
}

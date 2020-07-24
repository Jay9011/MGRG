package com.mgrg.hrm.login;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;

public class MemNoticeCommand implements BCommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		INotiDAO dao = C.sqlSession.getMapper(INotiDAO.class);
		
		
		
	}

	

}

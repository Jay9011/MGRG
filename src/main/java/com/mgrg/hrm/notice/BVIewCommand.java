package com.mgrg.hrm.notice;

import java.util.Arrays;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class BVIewCommand implements Command{

	@Override
	public void execute(Model model) {
		IBoard dao = D.sqlSession.getMapper(IBoard.class);
		NoticeJSON list = new NoticeJSON();
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		BoardDTO arr = null;
		int uid = (int) model.getAttribute("uid");
		
		try {
			if(uid == 0) {
				message.append("[uid를 찾을수 없어요]");
			}else {
				arr = dao.bSelectUid(uid);
				status = "OK";
			}
		}catch (Exception e) {
			message.append("[트랜잭션 에러 : " + e.getMessage() + "]");
		}
		list.setMessage(message.toString());
		list.setStatus(status);
		list.setList(Arrays.asList(arr));
		
		model.addAttribute("list",list);
		
	}

}
package com.mgrg.hrm.notice;

import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class BListCommand implements Command{

	@Override
	public void execute(Model model) {
		IBoard dao = D.sqlSession.getMapper(IBoard.class);
		List<BoardDTO> arr = null;
		NoticeJSON list = new NoticeJSON();
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		
		try {
		arr = dao.bSelect();
		
		if(arr == null) {
			message.append("[공지사항 목록이 없습니다]");
		} else {
			status = "OK";
		}
		
		} catch (Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		}
		list.setMessage(message.toString());
		list.setStatus(status);
		list.setList(arr);
		
		
		model.addAttribute("list", list);
	
	}
}

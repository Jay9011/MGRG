package com.mgrg.hrm.notice;

import java.util.Map;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class BdeleteCommand implements Command{

	@Override
	public void execute(Model model) {
		int cnt = 0;
		
		IBoard dao = D.sqlSession.getMapper(IBoard.class);
		NoticeJSON list = new NoticeJSON();
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		int[] uids = (int[]) model.getAttribute("uids");
		System.out.println(uids.length +" ");
		try {
			cnt = dao.bDeleteUids(uids);
			if(cnt == 0) {
				message.append("[데이터 삭제 실패]");
			}else {
				status = "OK";
				message.append("삭제 성공");
			}
		}catch (Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage() + "]");
		}
		list.setMessage(message.toString());
		list.setStatus(status);
		list.setCount(cnt);

		model.addAttribute("list",list);
	}
	

}

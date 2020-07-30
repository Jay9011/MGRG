package com.mgrg.hrm.commute;

import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class HdelCommand  implements Command{

	@Override
	public void execute(Model model) {
		int cnt = 0;
		HoliyDAO dao = D.sqlSession.getMapper(HoliyDAO.class);
		HolidayJSON list = new HolidayJSON();
		StringBuffer message = new StringBuffer();
		String status = "FAIL";   // 기본 FAIL
		
		int uid = (int) model.getAttribute("uid");
		
		try {
			cnt = dao.Hdeluid(uid);
			if(cnt == 0) {
				message.append("삭제할 휴가가 없습니다.");
			}else {
				status = "OK";
				message.append("님의 휴가가 삭제 되었습니다.");
				
			}
		}catch (Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage() + "]");
		}
		list.setCount(cnt);
		list.setStatus(status);
		list.setMessage(message.toString());
		
		model.addAttribute("list",list);
		
		
	}

}

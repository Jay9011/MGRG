package com.mgrg.hrm.pwchange;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;
import com.mgrg.hrm.JSONBase;

public class findIdPwCommand implements Command{

	@Override
	public void execute(Model model) {
		PwDAO dao = D.sqlSession.getMapper(PwDAO.class);
		JSONBase list = new JSONBase();
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		int cnt = 0;
		String id = (String) model.getAttribute("id");
		String pw = (String) model.getAttribute("pw");
		
		
		try {
			cnt =  dao.pwfindcount(id, pw);
			if(cnt == 0) {
				message.append("존재하지 않는 아이디, 비밀번호 입니다.");
			}else if(cnt > 0){
				status = "OK";
			}
		}catch (Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		}
		list.setCount(cnt);
		list.setMessage(message.toString());
		list.setStatus(status);
		
		model.addAttribute("list",list);
	
		
	}

}

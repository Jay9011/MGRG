package com.mgrg.hrm.pwchange;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.JSONBase;

public class ChangePassword implements Command {

	@Override
	public void execute(Model model) {
		JSONBase json = new JSONBase();
		String status = "FAIL";
		StringBuffer message = new StringBuffer();
		
		String id = (String) model.getAttribute("id");
		String pw = (String) model.getAttribute("pw");
		String pwnew = (String) model.getAttribute("pwnew");
		
		int result = 0;
		
		if(result == 0) {
			message.append("비밀번호 변경을 실패했습니다.");
			status = "OK";
		} else if (result > 0){
			message.append("정상적으로 비밀번호를 변경했습니다.");
			status = "OK";
		}
		
		json.setCount(result);
		json.setMessage(message.toString());
		json.setStatus(status);
		
		model.addAttribute("json", json);
	} // end execute()
}

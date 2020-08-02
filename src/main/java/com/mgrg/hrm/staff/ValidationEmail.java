package com.mgrg.hrm.staff;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class ValidationEmail implements Command {

	@Override
	public void execute(Model model) {
		StaffJSON json = new StaffJSON();
		StaffDAO dao = D.sqlSession.getMapper(StaffDAO.class);
		String email = (String) model.getAttribute("email");
		
		int result = dao.findByEmail(email);
		
		if(result > 0) {
			// id가 중복됨
			json.setMessage(email + "는 이미 존재하는 E-mail 입니다.");
			json.setStatus("FAIL");
		} else {
			// id 사용 가능
			json.setMessage(email + "는 사용 가능한 E-mail 입니다.");
			json.setStatus("OK");
		}
		
		model.addAttribute("json", json);

	}

}

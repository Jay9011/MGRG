package com.mgrg.hrm.staff;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class ValidationId implements Command {

	@Override
	public void execute(Model model) {
		StaffJSON json = new StaffJSON();
		StaffDAO dao = D.sqlSession.getMapper(StaffDAO.class);
		String id = (String) model.getAttribute("id");
		
		int result = dao.findById(id);
		
		if(result > 0) {
			// id가 중복됨
			json.setMessage(id + "는 이미 존재하는 아이디 입니다.");
			json.setStatus("FAIL");
		} else {
			// id 사용 가능
			json.setMessage(id + "는 사용 가능한 아이디 입니다.");
			json.setStatus("OK");
		}
		
		model.addAttribute("json", json);
		
	} // end execute()
} // end Command

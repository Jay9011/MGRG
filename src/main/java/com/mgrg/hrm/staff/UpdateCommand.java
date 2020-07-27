package com.mgrg.hrm.staff;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;
import com.mgrg.hrm.passwordGenerator.RandGenerator;

public class UpdateCommand implements Command {

	@Override
	public void execute(Model model) {
		StaffJSON json = new StaffJSON();
		StaffDAO dao = D.sqlSession.getMapper(StaffDAO.class);
		StaffDTO dto = (StaffDTO) model.getAttribute("dto");
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		int result = dao.update(dto);
		
		if(result > 0) {
			status = "OK";
			json.setCount(result);
		} else {
			message.append("[데이터를 추가하는데 실패했습니다.]");
			json.setMessage(message.toString());
		} // end if-else(result > 0)
		
		json.setStatus(status);
		
		model.addAttribute("json", json);
		
	} // end execute();

}

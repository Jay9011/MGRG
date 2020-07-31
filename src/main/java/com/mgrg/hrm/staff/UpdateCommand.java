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
		int result = 0;
		
		if(dto.getEmail() != null && dao.findByEmailWithoutUid(dto.getEmail(), dto.getUid()) > 0) {
			message.append("이미 존재하는 E-mail 입니다. 다시 확인해 주세요.");
			status = "Err_Em";
		} else if(dto.getPhonenum() != null && dao.findByPhonenumWithoutUid(dto.getPhonenum(), dto.getUid()) > 0) {
			message.append("이미 존재하는 전화번호 입니다. 다시 확인해 주세요.");
			status = "Err_Pn";
		} else {
			result = dao.update(dto);
			
			if(result > 0) {
				status = "OK";
				message.append(dto.getName() + "님의 정보를 성공적으로 수정했습니다.");
			} else {
				message.append("[데이터를 수정하는데 실패했습니다.]");
			} // end if-else(result > 0)
		}
		
		json.setCount(result);
		json.setMessage(message.toString());
		json.setStatus(status);
		
		model.addAttribute("json", json);
		
	} // end execute();

}

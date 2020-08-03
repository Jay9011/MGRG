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
		Validation vali = new Validation();
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		int result = 0;
		
		if(!vali.isVlidName(dto.getName())) {
			message.append("이름은 한글 혹은 영문자로만 2글자 에서 10글자 사이로 입력해 주세요.");
			status = "Err_Nm";
		} else if(dto.getBirthday() == null) {
			message.append("생일을 입력해 주세요.");
			status = "Err_Common";
		} else if(dto.getEmail() != null && dao.findByEmailWithoutUid(dto.getEmail(), dto.getUid()) > 0) {
			message.append("이미 존재하는 E-mail 입니다. 다시 확인해 주세요.");
			status = "Err_Em";
		} else if(!vali.isVlidEmail(dto.getEmail())) {
			message.append("E-mail 형식이 다릅니다. 다시 확인해 주세요.");
			status = "Err_Em";
		} else if(dto.getPhonenum() != null && dao.findByPhonenumWithoutUid(dto.getPhonenum(), dto.getUid()) > 0) {
			message.append("이미 존재하는 전화번호 입니다. 다시 확인해 주세요.");
			status = "Err_Pn";
		} else if(dto.getHiredate() == null) {
			message.append("입사 날짜를 입력해 주세요.");
			status = "Err_Common";
		} else if(dto.getSalary() == 0 ) {
			message.append("연봉을 입력해 주세요.");
			status = "Err_Common";
		} else{
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

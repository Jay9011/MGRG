package com.mgrg.hrm.staff;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;
import com.mgrg.hrm.mail.MailSendDefault;
import com.mgrg.hrm.passwordGenerator.RandGenerator;

public class InsertCommand implements Command {

	@Override
	public void execute(Model model) {
		StaffJSON json = new StaffJSON();
		StaffDAO dao = D.sqlSession.getMapper(StaffDAO.class);
		StaffDTO dto = (StaffDTO) model.getAttribute("dto");
		MailSendDefault mime = new MailSendDefault();
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		// 임시 비밀번호 생성
		RandGenerator genPw = new RandGenerator();
		String pw = genPw.getRandomPassword(5);
		dto.setPassword(pw);
		
		
		// 메일 보내기
		String setfrom = "ddnd194@naver.com";
		String tomail = dto.getEmail().trim();
		String title = "본사에 입사를 축하합니다.";
		String content = "아이디 : " + dto.getId() + "<br>" +
						"비밀번호 : <h2>" + pw + "</h2><br>";
		int result = mime.sendMail(setfrom, tomail, title, content);
		
		if(result == 1) {
			result = dao.insert(dto);
			
			if(result > 0) {
				status = "OK";
				message.append(dto.getName() + "님을 성공적으로 추가하였습니다.");
			} else {
				message.append("[데이터를 추가하는데 실패했습니다.]");
			} // end if-else(result > 0)
		} else {
			message.append("[이메일을 보내는데 실패했습니다.]");
		}

		json.setCount(result);
		json.setMessage(message.toString());
		json.setStatus(status);
		model.addAttribute("json", json);
	} // end execute();

} // end InsertCommand

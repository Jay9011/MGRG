package com.mgrg.hrm.staff;

import java.text.SimpleDateFormat;

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
		String content = "<div id='readFrame'><table style='margin:0 auto; background-color:#F7F8F8;' width='100%' cellspacing='0' cellpadding='0'><tbody><tr><td height='10'></td></tr><tr><td style='padding:0 10px'><table style='max-width:720px; background-color:#fff; table-layout:fixed; margin:0 auto; word-break:break-all; word-wrap:break-word;' width='100%' cellspacing='0' cellpadding='0'><tbody><tr style='background-color:#6547A6;'><td width='5.6%'></td><td><div style='padding:30px 0 28px 0;'><span style='color: white; font-size: 20px;'>본사에 입사를 환영합니다.</span></div></a></td><td width='5.6%'></td></tr ><tr><td width='5.6%'></td><td ><div style='margin:30px 0 0 0;' ><p style='margin:0 0 20px 0; text-align: center;' ><img src='https://thumbs.dreamstime.com/t/inscription-welcome-watercolor-illustration-bright-81141910.jpg' alt='' ></p ><p style='margin:15px 0 0 0; font-size:14px; line-height:22px; font-weight:normal; color:#111;'> 본사에 입사를 축하합니다.<br> " + dto.getName() + " 님은 " + new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(dto.getHiredate()) + " 부로 당사에 입사되었습니다.<br ></p ><div style='margin-top:30px; padding:25px 20px; border:1px solid #E2E4EE; border-left:0; border-right:0;'> 아이디 : <span style='color: #6547A6; font-size: 1.5em;'>" + dto.getId() + "</span><br> 비밀번호 : <span style='color: #6547A6; font-size: 1.5em;'>" + pw + "</span ></div ><div style='padding:25px 20px; border-bottom:1px solid #E2E4EE;'> 비밀번호 변경 주소 : <a href='http://localhost:8899/hrm/changePw'>http://localhost:8899/hrm/changePw</a ></div ></td><td width='5.6%'></td></tr ><tr><td width='5.6%'></td><td ><div style='margin:60px 0 30px 0' ><p style='margin:0 0 3px 0; font-size:13px; line-height:20px; font-weight:normal; color:#888;'> 본 메일은 발신전용입니다. 궁금한 사항을 문의하시려면 본사에 직접 문의하세요. </p ><p style='margin:0 0 3px 0; font-size:13px; line-height:20px; font-weight:normal; color:#888;'> ⓒ MGRG HRM System </p ></div ></td><td width='5.6%'></td></tr ></tbody></table ></td></tr ><tr><td height='10'></td></tr ></tbody></table ></div>";
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

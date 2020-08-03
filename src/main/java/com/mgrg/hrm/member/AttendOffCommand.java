package com.mgrg.hrm.member;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.JSONBase;
import com.mgrg.hrm.login.C;
import com.mgrg.hrm.login.ILoginDAO;

public class AttendOffCommand implements Command {

	@Override
	public void execute(Model model) {
		String status = "FAIL";
		StringBuffer message = new StringBuffer();
		JSONBase json = new JSONBase();
		ILoginDAO dao = C.sqlSession.getMapper(ILoginDAO.class);
		int uid = (int) model.getAttribute("uid");
		int result = 0;
		String inDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(Calendar.getInstance().getTime());
		
		if(dao.outCount(uid) > 0) {
			message.append("오늘(" + inDate + ") 이미 퇴근하셨습니다.");
		} else {
			result = dao.off(uid);
			message.append("현재(" + inDate + ") 시간으로 퇴근처리 되었습니다.");
			status = "OK";
		} // end if-else (출석여부)
		
		json.setMessage(message.toString());
		json.setStatus(status);
		json.setCount(result);
		
		model.addAttribute("json", json);
		
	} // end execute();

}

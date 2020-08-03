package com.mgrg.hrm.member;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.login.C;
import com.mgrg.hrm.login.ILoginDAO;

public class CheckAttendCommand implements Command {

	@Override
	public void execute(Model model) {
		String status = "FAIL";
		StringBuffer message = new StringBuffer();
		AttendanceJSON json = new AttendanceJSON();
		ILoginDAO dao = C.sqlSession.getMapper(ILoginDAO.class);
		int uid = (int) model.getAttribute("uid");
		
		ArrayList<AttendanceDTO> list = dao.selectAttendByUid(uid);
		
		if(list.size() < 1) {
			message.append("출근 정보가 없습니다.");
		}
		status = "OK";
		
		json.setData(list);
		json.setMessage(message.toString());
		json.setStatus(status);
		
		model.addAttribute("json", json);
		
	} // end execute()

}

package com.mgrg.hrm.staff;

import java.util.ArrayList;
import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class DeleteCommand implements Command{

	@Override
	public void execute(Model model) {
		StaffJSON json = new StaffJSON();
		StaffDAO dao = D.sqlSession.getMapper(StaffDAO.class);
		
		ArrayList<Integer> uids = (ArrayList<Integer>) model.getAttribute("uids"); 
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		int result = 0;
		result = dao.deleteStaffs(uids);
		
		if(result > 0) {
			status = "OK";
			message.append("성공적으로 삭제했습니다.");
		} else {
			message.append("[데이터를 삭제하는데 실패했습니다.]");
		} // end if-else(result > 0)
		
		json.setCount(result);
		json.setMessage(message.toString());
		json.setStatus(status);
		
		model.addAttribute("json", json);
	} // end execute()

} // end Command

package com.mgrg.hrm.staff;

import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.D;

public class ListCommand implements StaffCommand{

	@Override
	public void execute(Model model) {
		StaffJSON json = new StaffJSON();
		StaffDAO dao = D.sqlSession.getMapper(StaffDAO.class);
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		List<StaffDTO> list = dao.select();
		
		if(list.size() == 0) {
			message.append("[사원 목록을 불러오는데 실패했거나 사원 목록이 없습니다.]");
		} else {
			status = "OK";
		} // end if()
		
		json.setCount(list.size());
		json.setData(list);
		json.setMessage(message.toString());
		json.setStatus(status);
		
		model.addAttribute("json", json);
	} // end execute()

} // end Command 

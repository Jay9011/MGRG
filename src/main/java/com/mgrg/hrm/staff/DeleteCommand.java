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
		
		System.out.println(uids);
		int result = 0;
		result = dao.deleteStaffs(uids);
	} // end execute()

} // end Command

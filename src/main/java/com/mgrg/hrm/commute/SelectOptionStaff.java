package com.mgrg.hrm.commute;

import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;
import com.mgrg.hrm.staff.StaffBasicDTO;
import com.mgrg.hrm.staff.StaffHolidayDTO;

public class SelectOptionStaff implements Command {

	@Override
	public void execute(Model model) {
		StaffBasicDTO dto = new StaffBasicDTO();
		HoliyDAO dao = D.sqlSession.getMapper(HoliyDAO.class);
		Integer dep_uid = (Integer) model.getAttribute("dep_uid");
		Integer p_uid = (Integer) model.getAttribute("p_uid");

		List<StaffHolidayDTO> list = dao.selectStaff(dep_uid, p_uid);
		
		model.addAttribute("list", list);
		
	} // end execute()

} // end Command
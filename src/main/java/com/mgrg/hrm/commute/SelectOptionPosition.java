package com.mgrg.hrm.commute;

import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class SelectOptionPosition implements Command {

	@Override
	public void execute(Model model) {
		DepartmentDTO dto = new DepartmentDTO();
		HoliyDAO dao = D.sqlSession.getMapper(HoliyDAO.class);

		List<PositionDTO> list = dao.selectPosition();
		
		model.addAttribute("list", list);
		
	} // end execute()

} // end Command

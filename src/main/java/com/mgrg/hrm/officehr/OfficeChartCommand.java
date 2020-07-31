package com.mgrg.hrm.officehr;

import java.sql.Timestamp;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class OfficeChartCommand implements Command {

	@Override
	public void execute(Model model) {
		OhJSON json = new OhJSON();
		OhDAO dao = D.sqlSession.getMapper(OhDAO.class);
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		Timestamp thisMonth = null;
		int uid = (int)model.getAttribute("uid");
		
		try {
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}

package com.mgrg.hrm.commute;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;

public class HolidayCommand implements Command {

	@Override
	public void execute(Model model) {
		Date startDay = null;
		Date endDay = null;
		
		try {
			startDay = new SimpleDateFormat("yyyy-MM-dd").parse((String) model.getAttribute("startDay"));
			endDay = new SimpleDateFormat("yyyy-MM-dd").parse((String) model.getAttribute("endDay"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
	} // end execute()
} // end Command

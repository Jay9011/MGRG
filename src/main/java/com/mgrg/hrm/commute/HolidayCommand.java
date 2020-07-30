package com.mgrg.hrm.commute;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;

public class HolidayCommand implements Command {

	@Override
	public void execute(Model model) {
		final String DATE_PATTERN = "yyyy-MM";
		Date startDay = null;
		Date endDay = null;
		Date firstDay = null;
		try {
			startDay = new SimpleDateFormat("yyyy-MM-dd").parse((String) model.getAttribute("startDay"));
			endDay = new SimpleDateFormat("yyyy-MM-dd").parse((String) model.getAttribute("endDay"));
			firstDay = startDay;
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
			ArrayList<String> dates = new ArrayList<String>();
			while (firstDay.compareTo(endDay) <= 0) {
				dates.add(sdf.format(firstDay));
				Calendar c = Calendar.getInstance();
				c.setTime(firstDay);
				c.add(Calendar.DAY_OF_MONTH, 1);
				firstDay = c.getTime();
			}
			for (String date : dates) {
				System.out.println(date);
			}
			
			
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
	} // end execute()
} // end Command

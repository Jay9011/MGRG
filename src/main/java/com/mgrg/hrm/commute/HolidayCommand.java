package com.mgrg.hrm.commute;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;


import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;
import com.mgrg.hrm.DateMathod;

public class HolidayCommand implements Command {

	@Override
	public void execute(Model model) {
		HolidayJSON json = new HolidayJSON();
		LocalDate startDay = null;
		LocalDate endDay = null;
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		try {
			startDay = LocalDate.parse((String) model.getAttribute("startDay"));
			endDay = LocalDate.parse((String) model.getAttribute("endDay"));
			String sEmp_uid = (String) model.getAttribute("emp_uid");
			int emp_uid = 0;
			if(sEmp_uid != null && !sEmp_uid.trim().equals("")) {
				/* 추가하는 부분 */
				HoliyDAO dao = D.sqlSession.getMapper(HoliyDAO.class);
				emp_uid = Integer.parseInt(sEmp_uid);
				status = "OK";
//				long monthBetween = ChronoUnit.MONTHS.between(YearMonth.from(startDay), YearMonth.from(endDay));
//				int startMonth = startDay.getMonthValue();
//				int endMonth = endDay.getMonthValue();
//				System.out.println(startMonth + "월 부터 " + endMonth + "월 까지 " + monthBetween + "개월 차이");
//				System.out.println(startDay.toString() + " ~ " + endDay.toString());
				
				
//				dao.insertHoliday(startDay, endDay, emp_uid);
				DateMathod dm = new DateMathod();
				List<LocalDate> list = dm.getAllDates(startDay, endDay);
				for (LocalDate date : list) {
				}
			} else {
				message.append("회원 정보가 없습니다. 잠시 후 다시 시도해 주세요.");
			}
		} catch (DateTimeParseException de) {
			/* 에러 부분*/
			message.append("시간이 잘못 되었거나 비어있습니다.");
		}
		/* JSON 보내기 */
		json.setStatus(status);
		json.setMessage(message.toString());
		model.addAttribute("json", json);
		
	} // end execute()
} // end Command

package com.mgrg.hrm.commute;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class HcalCommand implements Command{

	@Override
	public void execute(Model model) {
		final String DATE_PATTERN = "yyyy-MM-dd";
		HoliyDAO dao = D.sqlSession.getMapper(HoliyDAO.class);
		HolidayJSON Hlist = new HolidayJSON();
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		List<HoliyDTO> dto = null;
		
		ArrayList<StatusDTO> dates = new ArrayList<StatusDTO>();
		int emp_uid = (Integer)model.getAttribute("emp_uid");
		try {
			if(emp_uid == 0) {
				message.append("[uid를 찾을수 없어요]");
			}else {
				dto = dao.hSelect(emp_uid);
				for (HoliyDTO hol : dto) {
					String inputStartDate = hol.getStartTime();
					String inputEndDate = hol.getEndTime();
					SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
					Date startDate = sdf.parse(inputStartDate);
					Date endDate = sdf.parse(inputEndDate);
					Date currentDate = startDate;
					while (currentDate.compareTo(endDate) <= 0) {
						StatusDTO sDto = new StatusDTO(sdf.format(currentDate),"holiday",false);
						dates.add(sDto);
						Calendar c = Calendar.getInstance();
						c.setTime(currentDate);
						c.add(Calendar.DAY_OF_MONTH, 1);
						currentDate = c.getTime();
					}
					
				}
				
				status = "OK";
			}
		}catch (Exception e) {
			message.append("[트랜잭션 에러 : " + e.getMessage() + "]");
		}
		Hlist.setMessage(message.toString());
		Hlist.setStatus(status);
		Hlist.setData(dto);
		
		model.addAttribute("dates",dates);
		//model.addAttribute("Hlist",Hlist);
		
	}

}

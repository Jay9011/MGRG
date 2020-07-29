package com.mgrg.hrm.commute;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;
import com.mgrg.hrm.officehr.OhDTO;

public class HcalCommand implements Command{

	@Override
	public void execute(Model model) {
		final String DATE_PATTERN = "yyyy-MM-dd";
		String inputStartDate = "";
		String inputEndDate = "";
		SimpleDateFormat sdf;
		Date startDate;
		
		// 휴가 데이터 가져오기
		HoliyDAO dao = D.sqlSession.getMapper(HoliyDAO.class);
		HolidayJSON Hlist = new HolidayJSON();
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		List<HoliyDTO> dto = null;
		
		// 근태 데이터 가져오기
		List<OhDTO> oDto = null;
		
		
		ArrayList<StatusDTO> dates = new ArrayList<StatusDTO>();
		int emp_uid = (Integer)model.getAttribute("emp_uid");
		try {
			if(emp_uid == 0) {
				message.append("[uid를 찾을수 없어요]");
			}else {
				dto = dao.hSelect(emp_uid);
				for (HoliyDTO hol : dto) {
					inputStartDate = hol.getStartTime();
					inputEndDate = hol.getEndTime();
					sdf = new SimpleDateFormat(DATE_PATTERN);
					startDate = sdf.parse(inputStartDate);
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
					// 근태 현황 데이터 출력해 add 
					oDto = dao.oSelect(emp_uid);
					for (OhDTO oHdto : oDto) {
						 inputStartDate = oHdto.getStart();
						 sdf = new SimpleDateFormat(DATE_PATTERN);
						 startDate = sdf.parse(inputStartDate);
						 if(oHdto.getStatus().equals("출근") || oHdto.getStatus().equals("퇴근")  ) {
							 StatusDTO sDto = new StatusDTO(sdf.format(startDate),"absence",false);
							//System.out.println(sdf.format(startDate));
							 dates.add(sDto);							 
						 }else if(oHdto.getStatus().equals("지각")) {
							 StatusDTO sDto = new StatusDTO(sdf.format(startDate),"late",false);
							 dates.add(sDto);
							// System.out.println(sdf.format(startDate));
						 }else if(oHdto.getStatus().equals("결근")) {
							 StatusDTO sDto = new StatusDTO(sdf.format(startDate),"attend",false);
							 dates.add(sDto);
							// System.out.println(sdf.format(startDate));
						 }else {
							// System.out.print(sdf.format(startDate));
							// System.out.println("없습니다");
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

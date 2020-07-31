package com.mgrg.hrm.commute;


import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

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
				
				DateMathod dm = new DateMathod();
				List<LocalDate> list = dm.getAllDates(startDay, endDay);
				List<HoliyDTO> addList = new ArrayList<HoliyDTO>();
				LocalDate start = null;
				LocalDate end = null;

				int index = 0;
				for (LocalDate date : list) {
					HoliyDTO dto = null;
					index++;
					
					if(start == null && date.getDayOfWeek() != DayOfWeek.SATURDAY && date.getDayOfWeek() != DayOfWeek.SUNDAY) {
						start = date;
					} // end if(start가 null 이고 주말이 아닐 때)
					
					if(date.getDayOfWeek() == DayOfWeek.SATURDAY) {
						dto = createDto(start, end, emp_uid);
						addList.add(dto);
						start = null;
					} // end if(date 가 토요일을 만났을 때)
					
					end = date;

					if(list.size() <= index) {
						dto = createDto(start, end, emp_uid);
						addList.add(dto);
					} // end if(list를 전부 봤다면)
				} // end for-each
				
				// 만들어진 모든 날짜 넣기
				for (HoliyDTO holiyDTO : addList) {
//					System.out.println(holiyDTO.toString());
					dao.insertHoliday(holiyDTO);
				} // end for-each
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
	
	public HoliyDTO createDto(LocalDate start, LocalDate end, int uid) {
		// start 나 end 둘 중 하나라도 null 이면 안된다.
		if(start != null && end != null) {
			HoliyDTO dto = new HoliyDTO();
			dto.setStartTime(Timestamp.valueOf(start.atStartOfDay()));
			dto.setEndTime(Timestamp.valueOf(end.atStartOfDay()));
			dto.setEmpuid(uid);
			return dto;
		}
		return null;
	} // end createDto()
} // end Command

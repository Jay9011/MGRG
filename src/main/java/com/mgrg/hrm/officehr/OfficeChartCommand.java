package com.mgrg.hrm.officehr;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class OfficeChartCommand implements Command {

	@Override
	public void execute(Model model) {
		OhJSON json = new OhJSON();
		ChartDAO dao = D.sqlSession.getMapper(ChartDAO.class);
		ChartDTO dto = new ChartDTO();
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		Timestamp thisMonth = null;
		int uid = (int)model.getAttribute("uid");
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		Calendar cal = Calendar.getInstance();
		String today = null;
		today = formatter.format(cal.getTime());
		Timestamp date = Timestamp.valueOf(today);
		System.out.println(date);
		List<ChartDTO> list = null;
		
		try {
			int holiday = dao.holiCnt(uid, date);
			list = dao.chartList(uid, date);
			list.get(0).setHoliday(holiday);
			if(list.size() != 0) {
				status = "OK";
				message.append(list.size() + " 개");
			} else {
				status = "FAIL";
				message.append("트랜잭션 실패!!");
			}
			
			json.setStatus(status);
			json.setCount(list.size());
			json.setChartData(list);
			json.setMessage(message.toString());
			model.addAttribute("json", json);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
	}

}

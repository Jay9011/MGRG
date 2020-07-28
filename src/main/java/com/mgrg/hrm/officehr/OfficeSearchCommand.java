package com.mgrg.hrm.officehr;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class OfficeSearchCommand implements Command {

	@Override
	public void execute(Model model) {
		OhJSON json = new OhJSON();
		OhDAO dao = D.sqlSession.getMapper(OhDAO.class);
		List<OhDTO> list;
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		// parameters 받아오기
		int option = (int) model.getAttribute("searchOpt");
		String input = (String)model.getAttribute("searchInput");
		String start = (String)model.getAttribute("startDate");
		String end = (String)model.getAttribute("endDate");
		if(!start.equals("")) start += " 00:00:00";
		if(!end.equals("")) end += " 00:00:00";
		
		Timestamp startDate = null;
		Timestamp endDate = null;
		
		if(input == "" || input == null || option == 0 || start.equals("") || end.equals("")) {
			// 검색 창에 아무것도 안 적었을 때 처리할 사항
			list = dao.select_By_Search(option, input, startDate, endDate);
			json.setCount(list.size());
			json.setData(list);
			json.setMessage(message.toString());
			json.setStatus(status);
			model.addAttribute("json", json);
			return;
		} else {
			try {
				if(!start.equals("") && start != null) {
					startDate = java.sql.Timestamp.valueOf(start);
				}
				if(!end.equals("") || end != null) {
					endDate = java.sql.Timestamp.valueOf(end);
				}
				list = dao.select_By_Search(option, input, startDate, endDate);
				if(list.size() == 0) {
					message.append("[해당 목록이 없습니다]");
				} else {
					status = "OK";
					message.append("[해당 직원 근태 현황 목록을 " + list.size() + "개 들고 옵니다]");
				}
				json.setCount(list.size());
				json.setData(list);
				json.setMessage(message.toString());
				json.setStatus(status);
				model.addAttribute("json", json);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
	}

}

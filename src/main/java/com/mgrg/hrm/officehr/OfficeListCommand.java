package com.mgrg.hrm.officehr;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class OfficeListCommand implements Command{

	@Override
	public void execute(Model model) {
		OhJSON json = new OhJSON();
		OhDAO dao = D.sqlSession.getMapper(OhDAO.class);
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		Date d = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String date = format.format(d);
		
		List<OhDTO> list = dao.select_officehr(date);
		
		if(list.size() == 0) {
			message.append("[직원들의 근태현황 목록이 없습니다.]");
		} else {
			status = "OK";
			message.append("[직원들의 근태현황을 " + list.size() + "개 출력합니다.]");
		} // end if()
		
		json.setCount(list.size());
		json.setData(list);
		json.setMessage(message.toString());
		json.setStatus(status);
		
		model.addAttribute("json", json);
	} // end execute()

} // end Command 

package com.mgrg.hrm.login;

import java.util.ArrayList;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.commute.HcalCommand;
import com.mgrg.hrm.commute.HolidayJSON;
import com.mgrg.hrm.commute.StatusDTO;
import com.mgrg.hrm.notice.BoardDTO;
import com.mgrg.hrm.notice.NoticeJSON;

@RestController
@RequestMapping("/login")
public class AumainController {
	@RequestMapping("view.mem")
	public NoticeJSON mView(int uid, Model model) {
		model.addAttribute("uid",uid);
		new MViewCommand().execute(model);
		NoticeJSON list = (NoticeJSON)model.getAttribute("Mlist");
		return list;
	}
	
	@RequestMapping("cal.mem")
	public ArrayList<StatusDTO> calView(Model model,int empuid) {
		model.addAttribute("emp_uid", empuid);
		new HcalCommand().execute(model);
		 ArrayList<StatusDTO> list = (ArrayList<StatusDTO>) model.getAttribute("dates");
		return list;
	}
	
}

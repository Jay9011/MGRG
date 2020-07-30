package com.mgrg.hrm.Controller;

import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.commute.HElistCommand;
import com.mgrg.hrm.commute.HEmJSON;
import com.mgrg.hrm.commute.HdelCommand;
import com.mgrg.hrm.commute.HolidayCommand;
import com.mgrg.hrm.commute.HolidayJSON;

@RestController
@RequestMapping("/holiy")
public class HolidayRestController {
	
	@PostMapping("addHoliday")
	public HolidayJSON addHoliday(Model model, @RequestParam Map<String, String> param) {
//		param.get("startDay"), param.get("endDay")
//		model.getAttribute("startDay"), model.getAttribute("endDay")
		model.addAllAttributes(param);

		System.out.println(model.getAttribute("startDay") + " ~ " + model.getAttribute("endDay"));

		new HolidayCommand().execute(model);
		HolidayJSON json = (HolidayJSON) model.getAttribute("json");
		return json;
	} // end addHoliday()
	
	@RequestMapping("Hlist.hol")
	public HEmJSON Hlist(Model model) {
		new HElistCommand().execute(model);
		HEmJSON list = (HEmJSON) model.getAttribute("list");
		return list;
	}
	@RequestMapping("Hdel.hol")
	public HolidayJSON Hdel(Model model) {
		new HdelCommand().execute(model);
		HolidayJSON list = (HolidayJSON) model.getAttribute("list");
		return list;
	}
	
}

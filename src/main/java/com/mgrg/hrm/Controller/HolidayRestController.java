package com.mgrg.hrm.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.commute.DepartmentDTO;
import com.mgrg.hrm.commute.HElistCommand;
import com.mgrg.hrm.commute.HEmJSON;
import com.mgrg.hrm.commute.HdelCommand;
import com.mgrg.hrm.commute.HolidayCommand;
import com.mgrg.hrm.commute.HolidayJSON;
import com.mgrg.hrm.commute.PositionDTO;
import com.mgrg.hrm.commute.SelectOptionDepartment;
import com.mgrg.hrm.commute.SelectOptionPosition;
import com.mgrg.hrm.commute.SelectOptionStaff;
import com.mgrg.hrm.staff.StaffBasicDTO;
import com.mgrg.hrm.staff.StaffDTO;
import com.mgrg.hrm.staff.StaffHolidayDTO;

@RestController
@RequestMapping("/holiy")
public class HolidayRestController {
	
	@PostMapping("addHoliday")
	public HolidayJSON addHoliday(Model model, @RequestParam Map<String, String> param) {
//		param.get("startDay"), param.get("endDay")
//		model.getAttribute("startDay"), model.getAttribute("endDay")
		model.addAllAttributes(param);
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
	
	@PostMapping("setSelectOptionDepartment")
	public ArrayList<DepartmentDTO> selectOptionDepartment(Model model){
		new SelectOptionDepartment().execute(model);
		ArrayList<DepartmentDTO> list = (ArrayList<DepartmentDTO>) model.getAttribute("list");
		return list;
	}

	@PostMapping("setSelectOptionPosition")
	public ArrayList<PositionDTO> selectOptionPosition(Model model){
		new SelectOptionPosition().execute(model);
		ArrayList<PositionDTO> list = (ArrayList<PositionDTO>) model.getAttribute("list");
		return list;
	}

	@PostMapping("setSelectOptionStaff")
	public ArrayList<StaffHolidayDTO> selectOptionStaff(Model model, @RequestParam("dep_uid") Integer dep_uid, @RequestParam("p_uid") Integer p_uid){
		model.addAttribute("dep_uid", dep_uid);
		model.addAttribute("p_uid", p_uid);
		new SelectOptionStaff().execute(model);
		ArrayList<StaffHolidayDTO> list = (ArrayList<StaffHolidayDTO>) model.getAttribute("list");
		return list;
	}

}

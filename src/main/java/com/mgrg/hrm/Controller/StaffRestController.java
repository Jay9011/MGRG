package com.mgrg.hrm.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.staff.ListCommand;
import com.mgrg.hrm.staff.StaffJSON;

@RestController
@RequestMapping("/staff")
public class StaffRestController {
	
//	@RequestMapping(value = "/list.json", method = RequestMethod.POST)
	@RequestMapping("/list")
	public StaffJSON createList(Model model) {
		new ListCommand().execute(model);
		StaffJSON json = (StaffJSON) model.getAttribute("json"); 
		return json;
	}
}

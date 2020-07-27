package com.mgrg.hrm.Controller;

import java.util.ArrayList;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.staff.DeleteCommand;
import com.mgrg.hrm.staff.InsertCommand;
import com.mgrg.hrm.staff.ListCommand;
import com.mgrg.hrm.staff.StaffDTO;
import com.mgrg.hrm.staff.StaffJSON;
import com.mgrg.hrm.staff.UpdateCommand;

@RestController
@RequestMapping("/staff")
public class StaffRestController {
	
//	@RequestMapping(value = "/list.json", method = RequestMethod.POST)
	@RequestMapping("/list")
	public StaffJSON createList(Model model) {
		new ListCommand().execute(model);
		StaffJSON json = (StaffJSON) model.getAttribute("json"); 
		return json;
	} // end createList()
	
	@RequestMapping(value = "/addStaff", method = RequestMethod.POST)
	public StaffJSON insertStaff(Model model, StaffDTO dto) {
		model.addAttribute("dto", dto);
		new InsertCommand().execute(model);
		StaffJSON json = (StaffJSON) model.getAttribute("json"); 
		return json;
	} // end insertStaff()

	@PostMapping("/modiStaff")
	public StaffJSON modiStaff(Model model, StaffDTO dto) {
		model.addAttribute("dto", dto);
		new UpdateCommand().execute(model);
		StaffJSON json = (StaffJSON) model.getAttribute("json"); 
		return json;
	} // end modiStaff()
	
	@PostMapping("/deleteStaff")
	public StaffJSON deleteStaff(Model model, @RequestParam(value = "uids[]") ArrayList<Integer> uids) {
		model.addAttribute("uids", uids);
		new DeleteCommand().execute(model);
		StaffJSON json = (StaffJSON) model.getAttribute("json"); 
		return json;
	} // end deleteStaff()
	
}

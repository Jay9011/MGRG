package com.mgrg.hrm.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.JSONBase;
import com.mgrg.hrm.member.AttendOffCommand;
import com.mgrg.hrm.member.AttendPresentCommand;
import com.mgrg.hrm.member.AttendanceJSON;
import com.mgrg.hrm.member.CheckAttendCommand;

@RestController
@RequestMapping("/login")
public class MemberController {
	
	@PostMapping("/checkAttend")
	public AttendanceJSON checkLog(Model model, @RequestParam("emp_uid") int uid) {
		model.addAttribute("uid", uid);
		new CheckAttendCommand().execute(model);
		AttendanceJSON json = (AttendanceJSON) model.getAttribute("json");
		return json;
	}
	
	@PostMapping("/present")
	public JSONBase present(Model model, @RequestParam("emp_uid") int uid) {
		model.addAttribute("uid", uid);
		new AttendPresentCommand().execute(model);
		JSONBase json = (JSONBase) model.getAttribute("json");
		return json;
	}
	
	@PostMapping("/off")
	public JSONBase off(Model model, @RequestParam("emp_uid") int uid) {
		model.addAttribute("uid", uid);
		new AttendOffCommand().execute(model);
		JSONBase json = (JSONBase) model.getAttribute("json");
		return json;
	}
}

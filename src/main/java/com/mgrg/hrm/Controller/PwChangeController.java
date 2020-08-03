package com.mgrg.hrm.Controller;

import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.JSONBase;
import com.mgrg.hrm.commute.HolidayCommand;
import com.mgrg.hrm.commute.HolidayJSON;
import com.mgrg.hrm.pwchange.ChangePassword;
import com.mgrg.hrm.pwchange.findIdPwCommand;

@RestController
@RequestMapping("/changePw")
public class PwChangeController {

	@RequestMapping("/findId")
	public JSONBase findIdPw(String id, String pw, Model model ) {
		model.addAttribute("id",id);
		model.addAttribute("pw",pw);
		new findIdPwCommand().execute(model);
		JSONBase list = (JSONBase) model.getAttribute("list");
		return list;
	}
	
	@PostMapping("/changePw")
	public JSONBase changePw(Model model, @RequestParam Map<String, String> param) {
		model.addAllAttributes(param);
		new ChangePassword().execute(model);
		JSONBase json = (JSONBase) model.getAttribute("json");
		return json;
	}
}

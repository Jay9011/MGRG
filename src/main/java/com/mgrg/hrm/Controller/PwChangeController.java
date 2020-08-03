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

@RestController
@RequestMapping("/changePw")
public class PwChangeController {

//	@RequestMapping("/findId")
	
	
	@PostMapping("/changePw")
	public JSONBase changePw(Model model, @RequestParam Map<String, String> param) {
		model.addAllAttributes(param);
		new ChangePassword().execute(model);
		JSONBase json = (JSONBase) model.getAttribute("json");
		return json;
	}
}

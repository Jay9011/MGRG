package com.mgrg.hrm.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.JSONBase;
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
	
}

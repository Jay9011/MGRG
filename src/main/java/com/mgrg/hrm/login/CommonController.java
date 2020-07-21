package com.mgrg.hrm.login;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {

	@RequestMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
					//Authentication   spring security 에서 제공함
		System.out.println("access Denied : "+auth);
		model.addAttribute("msg", "접근 권한 거부");
	}
	
	@GetMapping("/customLogout")
	public void logoutGet() {
		System.out.println("customLogout");
	}
}

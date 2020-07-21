package com.mgrg.hrm.login;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class LoginController {

	@GetMapping("/mainLoginPage")
	public void mainLogin(String error, String logout, Model model) {

		System.out.println("error : " + error); // 로그인 실패했을경우
		System.out.println("logout : " + logout);

		if (error != null) {
			model.addAttribute("error", "login Error check your id");

		}
		if (logout != null) {
			model.addAttribute("logout", "logout!!");

		}
	}
	
	@GetMapping("/adminMainPage")
	@PostMapping("/adminMainPage")
	public void adminMain() {
		
	}
}

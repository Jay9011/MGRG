package com.mgrg.hrm.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sample/*")
public class SampleController {
	@GetMapping("/all")  // @RequestMapping(method = RequestMethod.GET) 의 축약형
	public void doAll() {  // 리턴타입 없으면 url 과 같은 경로의 jsp 파일을 찾는다
		System.out.println("doAll() : access everybody");
	}
	
	@GetMapping("/member")
	public void doMember() {
		System.out.println("doMember() : access member only");
	}

	@GetMapping("/admin")
	public void doAdmin() {
		System.out.println("doAdmin() : access admin only");
	}
} // end Controller


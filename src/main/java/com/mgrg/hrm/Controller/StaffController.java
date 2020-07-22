package com.mgrg.hrm.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/staff")
public class StaffController {
	@RequestMapping("/")
	public String mainList() {
		return "list";
	} // end mainList()
} // end Controller

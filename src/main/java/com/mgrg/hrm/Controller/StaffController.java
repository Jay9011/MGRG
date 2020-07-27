package com.mgrg.hrm.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/staff")
public class StaffController {
	@RequestMapping("/")
	public String mainList() {
		return "list";
	} // end mainList()
} // end Controller

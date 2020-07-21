package com.mgrg.officehr;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OfficeHrController {
	
	@RequestMapping("/officehr")
	public String officeHr(Model model) {
		return "office_hour/office_hour";
	}
}

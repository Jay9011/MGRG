package com.mgrg.hrm.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/officehour")
public class OfficeHrController {
	
	// 관리자만 출근/결근/지각/휴가? 된 직원들을 추가/수정/삭제를 하기 위해 접근한다
	@RequestMapping("/list")
	public String officeHr(Model model) {
		return "office_hour/office_hour";
	}
}

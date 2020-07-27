package com.mgrg.hrm.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.officehr.OfficeListCommand;
import com.mgrg.hrm.officehr.OfficeUpdateCommand;
import com.mgrg.hrm.officehr.OhDTO;
import com.mgrg.hrm.officehr.OhJSON;

@RestController
@RequestMapping("/offhr")
public class OfficeHrRestController {
	
	// 관리자만 출근/결근/지각/휴가? 된 직원들을 추가/수정/삭제를 하기 위해 접근한다
	@PostMapping("/list")
	public OhJSON list(Model model) {
		new OfficeListCommand().execute(model);
		OhJSON json = (OhJSON) model.getAttribute("json"); 
		return json;
	}
	
	@PostMapping("/update")
	@GetMapping("/update")
	public OhJSON update(OhDTO dto, Model model) {
		model.addAttribute("dto", dto);
		new OfficeUpdateCommand().execute(model);
		OhJSON json = (OhJSON)model.getAttribute("json");
		return json;
	}
}

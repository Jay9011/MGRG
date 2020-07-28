package com.mgrg.hrm.Controller;

import java.sql.Timestamp;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.officehr.OfficeListCommand;
import com.mgrg.hrm.officehr.OfficeSearchCommand;
import com.mgrg.hrm.officehr.OfficeUpdateCommand;
import com.mgrg.hrm.officehr.OhDTO;
import com.mgrg.hrm.officehr.OhJSON;

@RestController
@RequestMapping("/offhour")
public class OfficeHrRestController {

	// 관리자만 출근/결근/지각/휴가? 된 직원들을 추가/수정/삭제를 하기 위해 접근한다
	/*
	 * @PostMapping("/list")
	 * 
	 * @GetMapping("/list")
	 */
//	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public OhJSON list(Model model) {
		new OfficeListCommand().execute(model);
		OhJSON json = (OhJSON) model.getAttribute("json");
		return json;
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public OhJSON update(OhDTO dto, Model model) {
		model.addAttribute("dto", dto);
		new OfficeUpdateCommand().execute(model);
		OhJSON json = (OhJSON) model.getAttribute("json");
		return json;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public OhJSON search(OhDTO dto, Model model, @RequestParam("searchOpt") int option,
			@RequestParam("searchInput") String input, @RequestParam("startDate") String startD,
			@RequestParam("endDate") String endD) {
		model.addAttribute("searchOpt", option);
		model.addAttribute("searchInput", input);
		model.addAttribute("startDate", startD);
		model.addAttribute("endDate", endD);
		model.addAttribute("dto", dto);
		new OfficeSearchCommand().execute(model);
		OhJSON json = (OhJSON) model.getAttribute("json");
		return json;
	}
}

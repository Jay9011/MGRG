package com.mgrg.hrm.Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.notice.BListCommand;
import com.mgrg.hrm.notice.NoticeJSON;

@RestController
@RequestMapping("/notice")
public class ANotiController {
	@RequestMapping("list.ajax")
	public NoticeJSON bList(HttpServletRequest request,Model model) {
		new BListCommand().execute(model);
		NoticeJSON list = (NoticeJSON) model.getAttribute("list");
		return list;
	}
//	
//	@RequestMapping("view.ajax")
//	public AjaxList bView(HttpServletRequest request,Model model) {
//		return bulidList(model);
//	}
//	@RequestMapping("writeOk.ajax")
//	public AjaxList bWriteOk(HttpServletRequest request,Model model) {
//		return bulidList(model);
//	}
	
	
	
	
}

package com.mgrg.hrm.login;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.notice.BoardDTO;
import com.mgrg.hrm.notice.NoticeJSON;

@RestController
@RequestMapping("/login")
public class AumainController {
	@RequestMapping("view.mem")
	public NoticeJSON mView(int uid, Model model) {
		model.addAttribute("uid",uid);
		new MViewCommand().execute(model);
		NoticeJSON list = (NoticeJSON)model.getAttribute("Mlist");
		return list;
		
	}
}

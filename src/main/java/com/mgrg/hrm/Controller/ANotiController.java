package com.mgrg.hrm.Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mgrg.hrm.notice.BListCommand;
import com.mgrg.hrm.notice.BVIewCommand;
import com.mgrg.hrm.notice.BdeleteCommand;
import com.mgrg.hrm.notice.BoardDTO;
import com.mgrg.hrm.notice.BupdateCommand;
import com.mgrg.hrm.notice.BwriteCommand;
import com.mgrg.hrm.notice.NoticeJSON;

@RestController
@RequestMapping("/notice")
public class ANotiController {
	@RequestMapping("/list.ajax")
	public NoticeJSON bList(HttpServletRequest request,Model model) {
		//System.out.println("들어는 오니??");
		new BListCommand().execute(model);
		NoticeJSON list = (NoticeJSON) model.getAttribute("list");
		return list;
	}

	@PostMapping("/writeOk.ajax")
	public NoticeJSON bWriteOk(BoardDTO dto, Model model) {
		//System.out.println("들어는 오니?");
		model.addAttribute("dto",dto);
		new BwriteCommand().execute(model);
		NoticeJSON list = (NoticeJSON) model.getAttribute("result");
		return list;
	}
	
	@RequestMapping("/view.ajax")
	public NoticeJSON bView(int uid, Model model) {
		//System.out.println("view 에오");
		model.addAttribute("uid",uid);
		new BVIewCommand().execute(model);
		NoticeJSON list = (NoticeJSON) model.getAttribute("list");
		return list;
	}
	@RequestMapping("/update.ajax")
	public NoticeJSON bupdate(BoardDTO dto, Model model) {
		model.addAttribute("dto",dto);
		new BupdateCommand().execute(model);
		NoticeJSON list = (NoticeJSON)model.getAttribute("list");
		return list;
	}
	
	@RequestMapping("/delete.ajax")
	public NoticeJSON bDelete(int[] uid, Model model) {
		model.addAttribute("uids",uid);
		new BdeleteCommand().execute(model);
		NoticeJSON list = (NoticeJSON) model.getAttribute("list");
		return list;
	}
	
}

package com.mgrg.hrm.Controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mgrg.hrm.login.C;
import com.mgrg.hrm.login.ILoginDAO;

@Controller
@RequestMapping("/officehour")
public class OfficeHrController {
	
	// 관리자만 출근/결근/지각/휴가? 된 직원들을 추가/수정/삭제를 하기 위해 접근한다
	@RequestMapping("/list")
	public String officeHr(Model model) {
		return "office_hour/office_hour";
	}
	
	@PostMapping("/present")
	public String present(HttpServletRequest request,HttpServletResponse response) {
		String empuid = request.getParameter("emp_uid");
		
		System.out.println("present() => "+empuid);
		int empuid2= Integer.parseInt(empuid);
		ILoginDAO dao = C.sqlSession.getMapper(ILoginDAO.class);
		dao.present(empuid2);
		try {
			response.sendRedirect(request.getContextPath()+"/login/member");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "login/member";
	}
	
	@PostMapping("/off")
	public String off(HttpServletRequest request,HttpServletResponse response) {
		String empuid = request.getParameter("emp_uid");
		
		System.out.println("present() => "+empuid);
		int empuid2= Integer.parseInt(empuid);
		ILoginDAO dao = C.sqlSession.getMapper(ILoginDAO.class);
		dao.off(empuid2);
		try {
			response.sendRedirect(request.getContextPath()+"/login/member");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "login/member";
	}
}

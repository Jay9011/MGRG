package com.mgrg.hrm.login;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class LoginController {

	private BCommand command;
	// mybatis용
	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		C.sqlSession = sqlSession;
	}

	@GetMapping("/mainLoginPage")
	public void mainLogin(String error, String logout, Model model) {

		System.out.println("error : " + error); // 로그인 실패했을경우
		System.out.println("logout : " + logout);

		if (error != null) {
			model.addAttribute("error", "login Error check your id");

		}
		if (logout != null) {
			model.addAttribute("logout", "logout!!");

		}
		

	}

	@RequestMapping("/member")
//	@PostMapping("/member")
	public String goMember(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id="";
		Enumeration<?> attributeNames = session.getAttributeNames();

		while (attributeNames.hasMoreElements()) {

			String name = (String) attributeNames.nextElement();

			if (name.equals("SPRING_SECURITY_CONTEXT")) {

				SecurityContext value = (SecurityContext) session.getAttribute(name);

				Authentication authentication = value.getAuthentication();

				User principal = (User) authentication.getPrincipal();

				WebAuthenticationDetails details = (WebAuthenticationDetails) authentication.getDetails();

				String username = authentication.getName();

				String password = (String) authentication.getCredentials();

				id = username;
			}

		}
		

		System.out.println("Controller 입니다"+id);
		model.addAttribute("id", id);
		command = new BSelectCommand();
		command.execute(model,request);
		
		return "login/member";

	}
	
	@GetMapping("/ad")
	public String main2(HttpServletRequest request) {
				// 세션 상세 정보 확인
				/////////////////////////////////////////////////////////////////////////
				HttpSession session = request.getSession();
				Enumeration<?> attributeNames = session.getAttributeNames();

				while (attributeNames.hasMoreElements()) {
					String name = (String) attributeNames.nextElement();

					if (name.equals("SPRING_SECURITY_CONTEXT")) {

						SecurityContext value = (SecurityContext) session.getAttribute(name);
						Authentication authentication = value.getAuthentication();
						User principal = (User) authentication.getPrincipal();
						WebAuthenticationDetails details = (WebAuthenticationDetails) authentication.getDetails();
						String username = authentication.getName();
						String password = (String) authentication.getCredentials();

						System.out.println(" \n\n\n ");
						System.out.println("///////////////////////////////////////////////////////////////////");
						System.out.println("////////////////////SPRING_SECURITY_CONTEXT ///////////////////////");
						System.out.println("///////////////////////////////////////////////////////////////////");
						System.out.println("name = " + name + "\n value = " + value.toString());
						System.out.println("authentication : " + authentication.toString());
						System.out.println("principal : " + principal);
						System.out.println("details : " + details.toString());
						System.out.println("username : " + username);
						System.out.println("password : " + password);
						System.out.println(" \n\n\n ");

					}
				}
		
		return "login/adminMainPage2";
	}
	
}

package com.mgrg.hrm.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;

public class BSelectCommand implements BCommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		ILoginDAO dao =  C.sqlSession.getMapper(ILoginDAO.class);
		Map<String, Object> map = model.asMap();
		String id = (String)map.get("id");
		SessionDTO dto =  dao.selectByIdPw(id);
		System.out.println("BSelectCommand : "+id);
		
		//세션을 받기 위해 request에서 세션을 받아옴
		HttpSession session = request.getSession(true);
		
		model.addAttribute("puid", dao.selectByIdPw(id));
	
		session.setAttribute("puid", dto.getP_uid());
		session.setAttribute("depuid", dto.getDep_uid());
		System.out.println("결과: " + (SessionDTO)model.getAttribute("puid"));
		
	}

}

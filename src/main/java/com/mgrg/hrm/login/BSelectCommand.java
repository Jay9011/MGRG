package com.mgrg.hrm.login;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

public class BSelectCommand implements BCommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		ILoginDAO dao =  C.sqlSession.getMapper(ILoginDAO.class);
		Map<String, Object> map = model.asMap();
		String id = (String)map.get("id");
		SessionDTO dto =  dao.selectByIdPw(id);
		
		System.out.println("BSelectCommand : "+id);
		
		INotiDAO dao2 = C.sqlSession.getMapper(INotiDAO.class);
		
		 
		List<NoticeDTO> dto2 = (List<NoticeDTO>) dao2.selectNoti(dto.getP_uid());
		//NoticeDTO dto2 = dao2.selectNoti(dto.getP_uid());
		
		//세션을 받기 위해 request에서 세션을 받아옴
		HttpSession session = request.getSession(true);
		
		
		model.addAttribute("puid", dao.selectByIdPw(id));
	
		
		session.setAttribute("puid", dto.getP_uid());
		session.setAttribute("depuid", dto.getDep_uid());
		/////////////////////////////////////////////////
		session.setAttribute("subject", ((NoticeDTO) dto2).getSubject());
		session.setAttribute("regdate", ((NoticeDTO) dto2).getRegdate());
		
		
		System.out.println("결과: " + (SessionDTO)model.getAttribute("puid"));
		
	}

}

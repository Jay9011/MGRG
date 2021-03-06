package com.mgrg.hrm.login;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.mgrg.hrm.fileupload.IDocDAO;
import com.mgrg.hrm.fileupload.docDTO;

public class BSelectCommand implements BCommand {

	@Override
	public void execute(Model model, HttpServletRequest request) {
		ILoginDAO dao = C.sqlSession.getMapper(ILoginDAO.class);
		Map<String, Object> map = model.asMap();
		String id = (String) map.get("id");
		SessionDTO dto = dao.selectByIdPw(id);

		System.out.println("BSelectCommand : " + id);

		INotiDAO dao2 = C.sqlSession.getMapper(INotiDAO.class);
		List<NoticeDTO>arr = dao2.selectNoti(dto.getP_uid(),dto.getDep_uid());
		model.addAttribute("list", arr);
		
		//int dto2 = dao.present(dto.getEmp_uid());
		
		//dao2.selectNoti(dto.getP_uid()); // 2개의 <NoticeDTO> 결과
		
		// 세션을 받기 위해 request에서 세션을 받아옴
		HttpSession session = request.getSession(true);

		model.addAttribute("puid", dao.selectByIdPw(id));

		session.setAttribute("puid", dto.getP_uid());
		session.setAttribute("depuid", dto.getDep_uid());
		session.setAttribute("empuid", dto.getEmp_uid());
		session.setAttribute("empname", dto.getEmp_name());
		/////////////////////////////////////////////////
		IDocDAO dao3 = C.sqlSession.getMapper(IDocDAO.class);
		List<docDTO> arr2 = dao3.select();
		model.addAttribute("doclist", arr2);
		
//		// 출근버튼 컨트롤러
//		int num = dao.loginCount(dto.getDep_uid());
//		System.out.println("로그인 했뉘?" + num);
//		session.setAttribute("numin", num);
//		
//		// 퇴근버튼 컨트롤러
//		int num2 = dao.outCount(dto.getDep_uid());
//		System.out.println("퇴근은 했뉘?" + num2);
//		session.setAttribute("numout", num2);

		System.out.println("결과: " + (SessionDTO) model.getAttribute("puid"));

	}

}

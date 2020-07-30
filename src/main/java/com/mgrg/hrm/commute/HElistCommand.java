package com.mgrg.hrm.commute;

import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class HElistCommand implements Command{

	@Override
	public void execute(Model model) {
		HoliyDAO dao = D.sqlSession.getMapper(HoliyDAO.class);
		List<HEmDTO> arr = null;
		HEmJSON list = new HEmJSON();
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		
		try {
			arr = dao.heSelect();
			if(arr == null) {
				message.append("[등록된 휴가가 없습니다.]");
			}else {
				status ="OK";
			}
		}catch (Exception e) {
			message.append("[트랜잭션 에러:" + e.getMessage()+ "]");
		}
		
		list.setMessage(message.toString());
		list.setStatus(status);
		list.setData(arr);
		
		model.addAttribute("list",list);
	}

}

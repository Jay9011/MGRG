package com.mgrg.hrm.officehr;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class OfficeUpdateCommand implements Command{

	@Override
	public void execute(Model model) {
		int cnt = 0;
		OhJSON json = new OhJSON();
		OhDAO dao = D.sqlSession.getMapper(OhDAO.class);
		OhDTO dto = null;
		
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		// 유효성 검사해주기
		try {
			dto = (OhDTO) model.getAttribute("dto");
			int uid = dto.getUid();
			String start = dto.getStart();
			String end = dto.getEnd();
			
			if(uid == 0) {
				message.append("존재하지 않는 직원 입니다.");
			} else if(start == "") {
				message.append("출근 시간이 찍히지 않았습니다.");
			} else if(end == "") {
				message.append("퇴근 시간이 찍히지 않았습니다.");
			} else {
				cnt = dao.updateHour(uid, start, end);
				if(cnt == 0) {
					message.append("트랜잭션 실패 : 0개 를 업데이트 했습니다.");
				} else {
					status = "OK";
					message.append("트랜잭션 성공 : " + cnt + "개 업데이트 했습니다.");
				}
			}
		} catch (Exception e) {
			message.append("트랜잭션 에러 " + e.getMessage());
		}
		
		json.setCount(cnt);
		json.setMessage(message.toString());
		json.setStatus(status);
		
		model.addAttribute("json", json);
		
	}

}

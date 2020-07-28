package com.mgrg.hrm.officehr;

import java.sql.Timestamp;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class OfficeUpdateCommand implements Command {

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
			int w_uid = dto.getW_uid();
			String startstr = dto.getStart();
			String endstr = dto.getEnd();
			Timestamp start = null;
			Timestamp end = null;

			if (uid == 0) {
				message.append("존재하지 않는 직원 입니다.");
			} else if (w_uid == 0) {
				message.append("잘못된 접근입니다.");
			} else {
				if(!startstr.equals("") && startstr != null)
					start = Timestamp.valueOf(startstr);
				if(!endstr.equals("") && endstr != null)
					end = Timestamp.valueOf(endstr);

				cnt = dao.updateHour(uid, w_uid, start, end);
				if (cnt == 0) {
					message.append("트랜잭션 실패 : 0개 를 업데이트 했습니다.");
				} else {
					status = "OK";
					message.append("트랜잭션 성공 : " + cnt + "개 업데이트 했습니다.");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			message.append("트랜잭션 에러 " + e.getMessage());
		}

		json.setCount(cnt);
		json.setMessage(message.toString());
		json.setStatus(status);

		model.addAttribute("json", json);

	}

}

package com.mgrg.hrm.notice;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class BupdateCommand implements Command{

	@Override
	public void execute(Model model) {
		int cnt = 0;
		IBoard dao = D.sqlSession.getMapper(IBoard.class);
		NoticeJSON list = new NoticeJSON();
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		
		BoardDTO dto = (BoardDTO) model.getAttribute("dto");
		
		int uid = dto.getUid();
		String subject = dto.getSubject();
		String content = dto.getContent();
		int dep_uid = dto.getDep_uid();
		int p_uid = dto.getP_uid();
		System.out.println(subject +content+ dep_uid +p_uid +""+uid);
		if(uid == 0) {
			message.append("존재하지 않는 uid 입니다.");
		}else if(subject == null || subject.trim().length() == 0) {
			message.append("[유효하지 않는 parmeter : 제목 필수");
		}else if(content == null || content.trim().length() ==0){
			message.append("[유효하지 않는 parmeter : 내용 필수");
		}else{
			try {
				cnt = dao.bUpdate(uid, subject, content, dep_uid, p_uid);
				if(cnt == 0) {
					message.append("[트랜젝션 실패 : 0 INSERT");
				}else {
					status = "OK";
					System.out.println("OK이라구");
				}
			}catch (Exception e) {
				message.append("[트랜잭션 에러 : " + e.getMessage() + "]");
			}
		}
		list.setCount(cnt);
		list.setMessage(message.toString());
		list.setStatus(status);
		
		model.addAttribute("list",list);
	}

}

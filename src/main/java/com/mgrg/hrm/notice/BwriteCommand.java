package com.mgrg.hrm.notice;

import java.util.List;

import org.springframework.ui.Model;

import com.mgrg.hrm.Command;
import com.mgrg.hrm.D;

public class BwriteCommand implements Command{

	@Override
	public void execute(Model model) {
		int cnt = 0;
		IBoard dao = D.sqlSession.getMapper(IBoard.class);
		NoticeJSON list = new NoticeJSON();
		
		BoardDTO dto = (BoardDTO) model.getAttribute("dto");
		StringBuffer message = new StringBuffer();
		String status = "FAIL"; // 기본 FAIL
		
		String subject = dto.getSubject();
		String content = dto.getContent();
		int dep_uid = dto.getDep_uid();
		int p_uid = dto.getP_uid();
		System.out.println(subject +content+ dep_uid +p_uid +"");
		if(subject == null || subject.trim().length() == 0) {
			message.append("[유효하지 않는 parmeter : 제목 필수");
		}else if(content == null || content.trim().length() ==0){
			message.append("[유효하지 않는 parmeter : 내용 필수");
		}else{
			try {
				cnt = dao.bInsert(subject, content, dep_uid, p_uid);
				System.out.println("들어 오냐구");
				if(cnt == 0) {
					message.append("[트랜젝션 실패 : 0 INSERT");
				}else {
					status = "OK";
					System.out.println("OK이라구");
				}
			}catch (Exception e) {
				e.printStackTrace();
				message.append("[트랜잭션 에러 : " + e.getMessage() + "]");
			}
		}
		list.setCount(cnt);
		list.setMessage(message.toString());
		list.setStatus(status);
		
		model.addAttribute("result", list);
	}

}


package com.mgrg.hrm.notice;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface IBoard {
	
	// 글전체 
	public List<BoardDTO> bSelect();
	
	// 글 작성
	public int bInsert(String subject, String content,@Param("dep_uid")int dep_uid, int p_uid);
	
	// 글 수정
	public int bUpdate(int uid, String subject, String content,int dep_uid, int p_uid);
	
	// 글들 삭제
	public int bDeleteUid(int []uids);
	
	// 글 읽기
	public BoardDTO bSelectUid(int uid);
	
	// 분류해서 나오기
	public BoardDTO belectUid1(int dep_uid, int p_uid);
	
	
	// 전체 글의 개수
	public int countAll();
	
	
}

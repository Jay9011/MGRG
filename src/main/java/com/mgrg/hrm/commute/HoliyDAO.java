package com.mgrg.hrm.commute;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mgrg.hrm.officehr.OhDTO;

public interface HoliyDAO {
	
	
	
	
	
	// 휴가 가져오기
	public List<HoliyDTO> hSelect(@Param("empuid") int emp_uid); 
	
	// 근태 현황 가져오기
	public List<OhDTO> oSelect(@Param("uid") int emp_uid);
	
	// 현재 년도의 한 사원의 휴가 일수 구하기
	
	
	
	// 모든 사원의 휴가 가져오기
	public List<HEmDTO> heSelect();
	
	// 해당 직원 휴가 삭제하기
	public int Hdeluid(int uid);

}

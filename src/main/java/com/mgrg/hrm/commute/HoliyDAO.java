package com.mgrg.hrm.commute;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface HoliyDAO {
	// 휴가 가져오기
	public List<HoliyDTO> hSelect(@Param("empuid") int emp_uid); 
}

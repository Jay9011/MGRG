package com.mgrg.hrm.commute;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mgrg.hrm.officehr.OhDTO;
import com.mgrg.hrm.staff.StaffHolidayDTO;

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

	// 부서 전부 뽑아오기
	public List<DepartmentDTO> selectDepartment();

	public List<PositionDTO> selectPosition();

	public List<StaffHolidayDTO> selectStaff(@Param("dep_uid") Integer dep_uid, @Param("p_uid") Integer p_uid);

	public int insertHoliday(@Param("startDay") LocalDate startDay, @Param("endDay") LocalDate endDay, @Param("emp_uid") Integer emp_uid);

}

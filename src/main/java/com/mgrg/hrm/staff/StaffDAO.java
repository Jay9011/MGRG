package com.mgrg.hrm.staff;

import java.util.ArrayList;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface StaffDAO {
	public ArrayList<StaffDTO> select();
	public int insert(StaffDTO dto);
	public int update(StaffDTO dto);
	public int deleteStaffs(ArrayList<Integer> uids);
	public int findById(String id);
	public int findByEmail(String email);
	public int findByPhonenum(int phonenum);
	public int findByEmailWithoutUid(String email, int uid);
	public int findByPhonenumWithoutUid(int phonenum, int uid);

	
}

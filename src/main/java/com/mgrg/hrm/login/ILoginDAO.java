package com.mgrg.hrm.login;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.mgrg.hrm.member.AttendanceDTO;


@MapperScan
public interface ILoginDAO {

	
	public SessionDTO selectByIdPw(String id);
	
	public String findPW(String id);
	
	public ValiDTO vali(String email, String id);
	public List<ValiDTO> vali2();
	
	public int present(int uid);
	
	public int off(int uid2);
	
	public int loginCount(int uid);
	public int outCount(int uid);

	public ArrayList<AttendanceDTO> selectAttendByUid(int uid);
	
}

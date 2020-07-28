package com.mgrg.hrm.login;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;


@MapperScan
public interface ILoginDAO {

	
	public SessionDTO selectByIdPw(String id);
	
	public String findPW(String id);
	
	public ValiDTO vali(String email, String id);
	public List<ValiDTO> vali2();
	
	public int present(int uid);
	
	public int off(int uid2);
}

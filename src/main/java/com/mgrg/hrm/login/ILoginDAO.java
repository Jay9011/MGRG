package com.mgrg.hrm.login;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface ILoginDAO {

	
	public SessionDTO selectByIdPw(String id);
}

package com.mgrg.hrm.login;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface INotiDAO {

	
	public NoticeDTO selectNoti(int puid);
	
}

package com.mgrg.hrm.login;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface INotiDAO {

	
	public List<NoticeDTO> selectNoti(int puid);
	
}

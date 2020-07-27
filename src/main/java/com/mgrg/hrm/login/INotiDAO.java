package com.mgrg.hrm.login;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface INotiDAO {

	
	public List<NoticeDTO> selectNoti(@Param("puid")int puid, @Param("depuid") int depuid);
	
}

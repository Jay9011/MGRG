package com.mgrg.hrm.officehr;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface OhDAO {
	public ArrayList<OhDTO> select_officehr(@Param("date")String date);
	public int updateHour(@Param("emp_uid")int uid, @Param("w_uid")int w_uid, @Param("w_start")Timestamp start, @Param("w_end")Timestamp end);
}

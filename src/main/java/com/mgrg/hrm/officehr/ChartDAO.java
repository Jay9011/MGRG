package com.mgrg.hrm.officehr;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface ChartDAO {
	public ArrayList<ChartDTO> chartList(@Param("uid") int uid, @Param("date")Timestamp date);
	public int holiCnt(@Param("uid")int uid, @Param("date")Timestamp date);
}

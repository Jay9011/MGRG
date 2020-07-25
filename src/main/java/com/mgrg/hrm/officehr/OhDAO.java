package com.mgrg.hrm.officehr;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface OhDAO {
	public ArrayList<OhDTO> select_officehr();
	public int updateHour(@Param("emp_uid")int uid);
}

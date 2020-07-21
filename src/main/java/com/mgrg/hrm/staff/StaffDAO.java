package com.mgrg.hrm.staff;

import java.util.ArrayList;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface StaffDAO {
	public ArrayList<StaffDTO> select();

}

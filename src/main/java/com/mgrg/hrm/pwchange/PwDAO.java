package com.mgrg.hrm.pwchange;


import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface PwDAO {
	public int pwfindcount( @Param("id")String uid, @Param("pw")String pw);

	public int updatePw(String id, String pw, String pwnew);
 
}

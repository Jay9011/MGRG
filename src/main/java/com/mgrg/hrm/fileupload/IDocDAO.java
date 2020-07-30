package com.mgrg.hrm.fileupload;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface IDocDAO {

	public int insert(String doc_title, String doc_content, String doc_file);
	
	public List<docDTO> select();
	
}

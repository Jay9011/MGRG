package com.mgrg.hrm.notice;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.mgrg.hrm.JSONBase;

public class NoticeJSON extends JSONBase{
	
	@JsonProperty("data")
	private List<BoardDTO> list;

	public List<BoardDTO> getList() {
		return list;
	}

	public void setList(List<BoardDTO> list) {
		this.list = list;
	}
	
	
}

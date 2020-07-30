package com.mgrg.hrm.commute;

import java.util.List;

import com.mgrg.hrm.JSONBase;

public class HEmJSON extends JSONBase{
	public List<HEmDTO> data;

	public List<HEmDTO> getData() {
		return data;
	}

	public void setData(List<HEmDTO> data) {
		this.data = data;
	}
	
	
}

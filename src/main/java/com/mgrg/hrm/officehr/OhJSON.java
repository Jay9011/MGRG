package com.mgrg.hrm.officehr;

import java.util.List;

import com.mgrg.hrm.JSONBase;

public class OhJSON extends JSONBase{
	private int count;
	
	private List<OhDTO> data;

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public List<OhDTO> getData() {
		return data;
	}

	public void setData(List<OhDTO> data) {
		this.data = data;
	}
	
	
}

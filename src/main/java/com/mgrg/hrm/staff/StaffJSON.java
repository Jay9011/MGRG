package com.mgrg.hrm.staff;

import java.util.List;

import com.mgrg.hrm.JSONBase;

public class StaffJSON extends JSONBase{
	private int count;

	private List<StaffDTO> data;
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List<StaffDTO> getData() {
		return data;
	}
	public void setData(List<StaffDTO> data) {
		this.data = data;
	}


}

package com.mgrg.hrm.commute;

import java.util.List;

import com.mgrg.hrm.JSONBase;

public class HolidayJSON extends JSONBase{
	private List<HoliyDTO> data;

	public List<HoliyDTO> getData() {
		return data;
	}

	public void setData(List<HoliyDTO> data) {
		this.data = data;
	}

}

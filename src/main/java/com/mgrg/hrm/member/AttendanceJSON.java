package com.mgrg.hrm.member;

import java.util.ArrayList;

import com.mgrg.hrm.JSONBase;

public class AttendanceJSON extends JSONBase{
	ArrayList<AttendanceDTO> data;

	public ArrayList<AttendanceDTO> getData() {
		return data;
	}

	public void setData(ArrayList<AttendanceDTO> data) {
		this.data = data;
	}
}

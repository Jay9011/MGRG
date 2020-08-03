package com.mgrg.hrm.member;

import java.sql.Timestamp;

public class AttendanceDTO {
	private String name;
	private Timestamp start;
	private Timestamp end;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getStart() {
		return start;
	}
	public void setStart(Timestamp start) {
		this.start = start;
	}
	public Timestamp getEnd() {
		return end;
	}
	public void setEnd(Timestamp end) {
		this.end = end;
	}
	
}

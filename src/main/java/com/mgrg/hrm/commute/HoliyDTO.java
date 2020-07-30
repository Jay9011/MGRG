package com.mgrg.hrm.commute;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class HoliyDTO {
	private int uid;
	private Timestamp startTime;
	private Timestamp endTime;
	private int empuid;
	
	
	public HoliyDTO() {
		super();
	}


	public HoliyDTO(int uid, Timestamp startTime, Timestamp endTime, int empuid) {
		super();
		this.uid = uid;
		this.startTime = startTime;
		this.endTime = endTime;
		this.empuid = empuid;
	}


	public int getUid() {
		return uid;
	}


	public void setUid(int uid) {
		this.uid = uid;
	}


	public String getStartTime() {
		return new SimpleDateFormat("yyyy-MM-dd").format(startTime);
	}


	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}


	public String getEndTime() {
		return new SimpleDateFormat("yyyy-MM-dd").format(endTime);
	}


	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}


	public int getEmpuid() {
		return empuid;
	}


	public void setEmpuid(int empuid) {
		this.empuid = empuid;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return startTime + " - " + endTime + " by " + empuid;
	}
	
	
	
}

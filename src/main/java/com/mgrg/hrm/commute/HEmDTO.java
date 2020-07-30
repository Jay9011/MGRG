package com.mgrg.hrm.commute;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class HEmDTO {
	private int uid;
	private int euid;
	private String name;
	private String position;
	private int phonenum;
	private String department;
	private Timestamp startTime;
	private Timestamp endTime;
	private int total;
	private int leftHoliday;
	private int useHoliday;
	
	
	public HEmDTO() {
		super();
	}


	public HEmDTO(int uid, int euid, String name, String position, int phonenum, String department, Timestamp startTime,
			Timestamp endTime, int total, int leftHoliday, int useHoliday) {
		super();
		this.uid = uid;
		this.euid = euid;
		this.name = name;
		this.position = position;
		this.phonenum = phonenum;
		this.department = department;
		this.startTime = startTime;
		this.endTime = endTime;
		this.total = total;
		this.leftHoliday = leftHoliday;
		this.useHoliday = useHoliday;
	}

	public String getDepartment() {
		return department;
	}


	public void setDepartment(String department) {
		this.department = department;
	}


	public int getPhonenum() {
		return phonenum;
	}



	public void setPhonenum(int phonenum) {
		this.phonenum = phonenum;
	}



	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public int getEuid() {
		return euid;
	}

	public void setEuid(int euid) {
		this.euid = euid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
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

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getLeftHoliday() {
		return leftHoliday;
	}

	public void setLeftHoliday(int leftHoliday) {
		this.leftHoliday = leftHoliday;
	}

	public int getUseHoliday() {
		return useHoliday;
	}

	public void setUseHoliday(int useHoliday) {
		this.useHoliday = useHoliday;
	}
	
	
	
}

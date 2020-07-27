package com.mgrg.hrm.officehr;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class OhDTO {
	private int uid;
	private String name;
	private String posRank;
	private String dept;
	private String status;
	private Timestamp start;
	private Timestamp end;

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPosRank() {
		return posRank;
	}

	public void setPosRank(String posRank) {
		this.posRank = posRank;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStart() {
//		java.sql.Timestamp t;
//		int year = end.getYear() + 1900;
//		int month = end.getMonth() + 1;
//		int day = end.getDate();
//		int hour = end.getHours();
//		int min = end.getMinutes();
//		int sec = end.getSeconds();
//		String startTime = "";
//		if (start == null) {
//			t = java.sql.Timestamp.valueOf(startTime);
//			return t;
//		} else {
//			startTime = year + "-" + month + "-" + day + " " + hour + ":" + min + ":" + sec;
//			t = java.sql.Timestamp.valueOf(startTime);
//			return t;
//		}
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(start);
	}

	public void setStart(Timestamp start) {
		this.start = start;
	}

	public String getEnd() {
//		int year = end.getYear() + 1900;
//		int month = end.getMonth() + 1;
//		int day = end.getDate();
//		int hour = end.getHours();
//		int min = end.getMinutes();
//		int sec = end.getSeconds();
//		String endTime = "";
		if (end == null) {
			return "";
		} else {
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(end);
		}
//		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date(end.getTime()));
	}

	public void setEnd(Timestamp end) {
		this.end = end;
		
	}

}

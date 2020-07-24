package com.mgrg.hrm.officehr;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class OhDTO {
	private int uid;
	private String name;
	private String posRank;
	private String dept;
	private String status;
	private Date start;
	private Date end;

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
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(start);
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public String getEnd() {
		if (end == null) {
			return "";
		} else {
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(end);
		}
	}

	public void setEnd(Date end) {
		this.end = end;
	}

}

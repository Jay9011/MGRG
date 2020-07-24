package com.mgrg.hrm.officehr;

import java.sql.Timestamp;

public class OhDTO {
	private int uid;
	private String name;
	private String posRank;
	private String dept;
	private String category;
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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

package com.mgrg.hrm.notice;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import com.fasterxml.jackson.annotation.JsonProperty;

public class BoardDTO {
	private Integer uid;
	private String subject;
	private String content;
	@JsonProperty("regdate")
	private Timestamp regDate;
	private int dep_uid;
	private int p_uid;
	private String department;
	private String position;
	
	
	
	public BoardDTO() {
		super();
	}
	
	
	public BoardDTO(int uid, String subject, String content, Timestamp regDate, int dep_uid, int p_uid,
			String department, String position) {
		super();
		this.uid = uid;
		this.subject = subject;
		this.content = content;
		this.regDate = regDate;
		this.dep_uid = dep_uid;
		this.p_uid = p_uid;
		this.department = department;
		this.position = position;
	}


	public String getDepartment() {
		return department;
	}


	public void setDepartment(String department) {
		this.department = department;
	}


	public String getPosition() {
		return position;
	}


	public void setPosition(String position) {
		this.position = position;
	}


	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	// 날짜를 정확히 나타내 주기 위해서
		public String getRegDate() {
			return new SimpleDateFormat("yyyy-MM-dd").format(regDate);
		}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public int getDep_uid() {
		return dep_uid;
	}
	public void setDep_uid(int dep_uid) {
		this.dep_uid = dep_uid;
	}
	public int getP_uid() {
		return p_uid;
	}
	public void setP_uid(int p_uid) {
		this.p_uid = p_uid;
	}
	
	
	

	
}

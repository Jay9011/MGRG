package com.mgrg.hrm.login;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class NoticeDTO {

	private int uid;		//n_uid
	private String subject;	//n_subject
	private String content;	//n_content
	private Timestamp regdate;	//n_regdate
	private int depuid;		//dep_uid;
	private int puid;		//p_uid
	
	
	public NoticeDTO() {
		super();
	}


	public NoticeDTO(int uid, String subject, String content, Timestamp regdate, int depuid, int puid) {
		super();
		this.uid = uid;
		this.subject = subject;
		this.content = content;
		this.regdate = regdate;
		this.depuid = depuid;
		this.puid = puid;
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


	public String getRegdate() {
		return new SimpleDateFormat("yyyy-MM-dd").format(regdate);
	}


	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}


	public int getDepuid() {
		return depuid;
	}


	public void setDepuid(int depuid) {
		this.depuid = depuid;
	}


	public int getPuid() {
		return puid;
	}


	public void setPuid(int puid) {
		this.puid = puid;
	}
	
	
	
	
	
}

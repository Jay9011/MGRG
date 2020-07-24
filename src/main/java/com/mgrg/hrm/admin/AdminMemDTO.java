package com.mgrg.hrm.admin;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class AdminMemDTO {

	private int uid;
	private String name;
	private String position;   //p_name
	private int salary;
	private String birth;
	
	public AdminMemDTO() {
		super();
	}

	public AdminMemDTO(int uid, String name, String position, int salary, String birth) {
		super();
		this.uid = uid;
		this.name = name;
		this.position = position;
		this.salary = salary;
		this.birth = birth;
	}

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

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}
	
	
		
}

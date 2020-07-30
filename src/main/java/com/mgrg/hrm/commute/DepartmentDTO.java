package com.mgrg.hrm.commute;

public class DepartmentDTO {
	Integer dep_uid;
	String dep_name;
	
	public DepartmentDTO() {
		super();
	}
	public DepartmentDTO(Integer dep_uid, String dep_name) {
		super();
		this.dep_uid = dep_uid;
		this.dep_name = dep_name;
	}
	public Integer getDep_uid() {
		return dep_uid;
	}
	public void setDep_uid(Integer dep_uid) {
		this.dep_uid = dep_uid;
	}
	public String getDep_name() {
		return dep_name;
	}
	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}
}

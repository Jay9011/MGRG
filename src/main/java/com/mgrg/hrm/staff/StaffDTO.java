package com.mgrg.hrm.staff;

import java.sql.Date;

public class StaffDTO {
	private int uid;
	private String name;
	private String birthday;
	private int phonenum;
	private String email;
	private String id;
	private String password;
	private String address;
	private Date hiredate;
	private int salary;
	private int p_uid;
	private String position;
	private String department;
	private int total;
	private int useHoliday;
	private int leftHoliday;
	
	public StaffDTO() {
		super();
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
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public int getPhonenum() {
		return phonenum;
	}
	public void setPhonenum(int phonenum) {
		this.phonenum = phonenum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public int getP_uid() {
		return p_uid;
	}
	public void setP_uid(int p_uid) {
		this.p_uid = p_uid;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
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

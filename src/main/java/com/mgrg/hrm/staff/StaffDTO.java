package com.mgrg.hrm.staff;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class StaffDTO extends StaffBasicDTO{
	
	private Timestamp birthday;
	private Integer phonenum;
	private String email;
	private String id;
	private String password;
	private String address;
	private String addrZoneCode;
	private String addrRoad;
	private String addrDetail;
	private Timestamp hiredate;
	private int salary;
	private int p_uid;
	private int dep_uid;
	private String position;
	private String department;
	private int total;
	private int useHoliday;
	private int leftHoliday;
	
	public StaffDTO() {
		super();
	}
	public String getBirthday() {
		return new SimpleDateFormat("yyyy-MM-dd").format(birthday);
	}
	public void setBirthday(Timestamp birthday) {
		this.birthday = birthday;
	}
	public Integer getPhonenum() {
		return phonenum;
	}
	public void setPhonenum(Integer phonenum) {
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
	public String getAddrZoneCode() {
		return addrZoneCode;
	}

	public void setAddrZoneCode(String addrZoneCode) {
		this.addrZoneCode = addrZoneCode;
	}

	public String getAddrRoad() {
		return addrRoad;
	}

	public void setAddrRoad(String addrRoad) {
		this.addrRoad = addrRoad;
	}

	public String getAddrDetail() {
		return addrDetail;
	}

	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}
	public Timestamp getHiredate() {
		return hiredate;
	}
	public void setHiredate(Timestamp hiredate) {
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

	public int getDep_uid() {
		return dep_uid;
	}

	public void setDep_uid(int dep_uid) {
		this.dep_uid = dep_uid;
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

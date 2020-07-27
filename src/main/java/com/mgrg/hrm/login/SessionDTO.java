package com.mgrg.hrm.login;

public class SessionDTO {

	// 내가 session에 담고 싶은 값들을 모두 넣어 로그인이 되었을 경우 기억하고 있어야
	// 한다
	
	// ----------------------------
	private int p_uid;
	private int dep_uid;
	private int emp_uid;
	private String emp_name;
	
	public SessionDTO() {
		super();
	}

	
//	public SessionDTO(int p_uid, int dep_uid, int emp_uid) {
//		super();
//		this.p_uid = p_uid;
//		this.dep_uid = dep_uid;
//		this.emp_uid = emp_uid;
//	}

	public SessionDTO(int p_uid, int dep_uid, int emp_uid, String emp_name) {
		super();
		this.p_uid = p_uid;
		this.dep_uid = dep_uid;
		this.emp_uid = emp_uid;
		this.emp_name = emp_name;
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

	public int getEmp_uid() {
		return emp_uid;
	}

	public void setEmp_uid(int emp_uid) {
		this.emp_uid = emp_uid;
	}


	public String getEmp_name() {
		return emp_name;
	}


	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	
	
	
	
	
}

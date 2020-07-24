package com.mgrg.hrm.login;

public class SessionDTO {

	// 내가 session에 담고 싶은 값들을 모두 넣어 로그인이 되었을 경우 기억하고 있어야
	// 한다
	
	// ----------------------------
	private int p_uid;
	private int dep_uid;
	
	public SessionDTO() {
		super();
	}

	public SessionDTO(int p_uid, int dep_uid) {
		super();
		this.p_uid = p_uid;
		this.dep_uid = dep_uid;
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
	
	
	
	
	
}

package com.mgrg.hrm.commute;

public class PositionDTO {
	Integer p_uid;
	String p_name;
	Integer p_level;
	Integer p_holiday;
	public PositionDTO() {
		super();
	}
	public PositionDTO(Integer p_uid, String p_name, Integer p_level, Integer p_holiday) {
		super();
		this.p_uid = p_uid;
		this.p_name = p_name;
		this.p_level = p_level;
		this.p_holiday = p_holiday;
	}
	public Integer getP_uid() {
		return p_uid;
	}
	public void setP_uid(Integer p_uid) {
		this.p_uid = p_uid;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public Integer getP_level() {
		return p_level;
	}
	public void setP_level(Integer p_level) {
		this.p_level = p_level;
	}
	public Integer getP_holiday() {
		return p_holiday;
	}
	public void setP_holiday(Integer p_holiday) {
		this.p_holiday = p_holiday;
	}
}

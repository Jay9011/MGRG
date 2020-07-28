package com.mgrg.hrm.commute;

public class StatusDTO {
	private String date;
	private String type;
	private boolean repeat;

	
	public StatusDTO() {
		super();
	}

	public StatusDTO(String date, String type, boolean repeat) {
		super();
		this.date = date;
		this.type = type;
		this.repeat = repeat;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public boolean isRepeat() {
		return repeat;
	}

	public void setRepeat(boolean repeat) {
		this.repeat = repeat;
	}
	
	
	
}

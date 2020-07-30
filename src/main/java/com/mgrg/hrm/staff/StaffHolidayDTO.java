package com.mgrg.hrm.staff;

public class StaffHolidayDTO extends StaffBasicDTO{
	private int total;
	private int useHoliday;
	private int leftHoliday;
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getUseHoliday() {
		return useHoliday;
	}
	public void setUseHoliday(int useHoliday) {
		this.useHoliday = useHoliday;
	}
	public int getLeftHoliday() {
		return leftHoliday;
	}
	public void setLeftHoliday(int leftHoliday) {
		this.leftHoliday = leftHoliday;
	}
}

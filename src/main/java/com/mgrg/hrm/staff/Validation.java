package com.mgrg.hrm.staff;

import java.sql.Timestamp;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validation {
	/**
	 * 이름 유효성 검사
	 * @param name
	 * @return
	 */
	public boolean isVlidName(String name) {
		String regex = "^[a-zA-Z가-힣]{2,10}";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(name);
		if (m.matches()) {
			return true;
		}
		return false;
	} // end isVlidName()
	
	/**
	 * 이메일 유효성 검사
	 * @param email
	 * @return
	 */
	public boolean isVlidEmail(String email) {
		String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(email);
		if (m.matches()) {
			return true;
		}
		return false;
	} // end isVlidEmail()
	
}

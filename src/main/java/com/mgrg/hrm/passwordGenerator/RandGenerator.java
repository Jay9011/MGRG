package com.mgrg.hrm.passwordGenerator;

public class RandGenerator {
	public String getRandomPassword(int length) {
		char[] set = new char[] {
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
				'U', 'V', 'W', 'X', 'Y', 'Z'
		};
		
		StringBuffer result = new StringBuffer();
		
		for (int i = 0; i < length; i++) {
			int index = (int) (set.length * Math.random());
			result.append(set[index]);
		} // end for
		
		return result.toString();
		
	} // end getRandomPassword() 
} // end Class

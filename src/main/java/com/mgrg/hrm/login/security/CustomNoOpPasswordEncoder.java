package com.mgrg.hrm.login.security;

import org.springframework.security.crypto.password.PasswordEncoder;



public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	// 매개변수로 받는 rawPassword를 인코딩하여 return 
	// 일반적으로 sha-1 혹은 그 이상의 암호화 알고리즘
	@Override
	public String encode(CharSequence rawPassword) {

		System.out.println("encode 전 = "+rawPassword);
		return rawPassword.toString();
	}

	
	//주어진 rawPassword가 인코딩 된 비밀번호와 동일한지 판정
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {

		System.out.println("matches 수행 : "+rawPassword + " :: " + encodedPassword);
		
		return rawPassword.toString().equals(encodedPassword);
	}

}

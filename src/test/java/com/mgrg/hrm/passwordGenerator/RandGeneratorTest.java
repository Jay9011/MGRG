package com.mgrg.hrm.passwordGenerator;

import static org.junit.Assert.*;

import org.junit.Test;

public class RandGeneratorTest {

	@Test
	public void test() {
		RandGenerator rand = new RandGenerator();
		String test = rand.getRandomPassword(5);
		System.out.println(test);
		assertNotNull(test);
	}

}

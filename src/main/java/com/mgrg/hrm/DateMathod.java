package com.mgrg.hrm;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class DateMathod {
	public List<LocalDate> getAllDates(LocalDate startDate, LocalDate endDate){
		List<LocalDate> dates = Stream.iterate(startDate, date -> date.plusDays(1))
				.limit(ChronoUnit.DAYS.between(startDate, endDate) + 1)
				.collect(Collectors.toList());
		
		return dates;
	}
}

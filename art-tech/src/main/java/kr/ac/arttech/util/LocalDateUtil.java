package kr.ac.arttech.util;

import java.time.LocalDate;

public class LocalDateUtil {
	
	public String currentDateTime() {
		LocalDate now = LocalDate.now();
		
		return "";
	}
	
	public static void main(String[] args) {
		LocalDate now = LocalDate.now();
		System.out.println(now.toString());
	}
}

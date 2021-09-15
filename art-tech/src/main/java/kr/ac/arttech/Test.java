package kr.ac.arttech;

import kr.ac.arttech.util.SecurityUtil;

public class Test {
	public static void main(String[] args) {
		String a = "왕하나:9408121234569";
		
		new SecurityUtil();
		String b = SecurityUtil.encryptSHA256(a);
		System.out.println(b);
		
	}
}

package kr.ac.bank.util;

import java.util.Date;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import kr.ac.bank.dto.MemberInfoDTO;

public class Token {
	
	//토큰 생성
	public static String createToken(String id) {
		Date now = new Date();
		return Jwts.builder()
				.setHeaderParam(Header.TYPE, Header.JWT_TYPE) //header의 타입
				.setIssuer("arttech") //토큰 발급자
				.setIssuedAt(now) //발급 시간
				.setExpiration(new Date(System.currentTimeMillis() + 1 * (1000 * 60 * 60 * 24 * 365))) //만료시간
				.claim("id", id)
				.signWith(SignatureAlgorithm.HS256, "secret")
				.compact();
	}
	
	//토큰 파싱
	public static Claims parseToken(String authorizationHeader) {
		//validationAuthorizationHeader(authorizationHeader); // (1)
		//System.out.println(authorizationHeader);
		String token = authorizationHeader; // (2) 

		return Jwts.parser()
	        .setSigningKey("secret") // (3)
	        .parseClaimsJws(token) // (4)
	        .getBody();
	}
	
	//정보 가져오기
	public static String getId(String token) {
		return parseToken(token).get("id").toString();
	}
	
	
	//만료기간 확인
	public static boolean checkExpToken(String token) {
		int diff = (Integer)parseToken(token).get("iat") - (Integer)parseToken(token).get("exp");
		if(diff < 0) {
			return true;
		}
		return false;
	}
	
	/*
	
	public static boolean checkExpToken(MemberInfoDTO memberInfoDTO) {
		int diff = (Integer)parseToken(memberInfoDTO.getToken()).get("iat") - (Integer)parseToken(memberInfoDTO.getToken()).get("exp");
		if(diff < 0) {
			return true;
		}
		return false;
	}
	*/
	
}

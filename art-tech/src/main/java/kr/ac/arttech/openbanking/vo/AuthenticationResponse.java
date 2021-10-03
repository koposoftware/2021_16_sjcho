package kr.ac.arttech.openbanking.vo;

public class AuthenticationResponse {
	public static String jwt;
	
	public AuthenticationResponse(String jwt) {
		this.jwt = jwt;
	}
}

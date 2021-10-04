package kr.ac.artTechManager.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO  {
	private String id;
	private String userId;
	private String password;
	private String name;
	private String phone;
	private String email;
	private String easyPassword; //간편비밀번호
	private String birth; //생년원일
	private String juminNo; //주민번호
	private String zipcode; //주소
	private String addr1Load ; //도로명주소
	private String addr1Jibun ; //지번주소
	private String addr2;
	private String gender; //성별
	private String privateKey;
	private String publicKey;
	private String kakaoId;
	private String regDate;
	private String withdrawalDate; //회원탈퇴
	private String receiveKakaoYn; //카카오 알림 받을건지
	private String memDeniedYn; 
	private String privacyAgreeYn; //오픈뱅킹 동의여부
	private String token; //오픈뱅킹 토큰
	private String fintechUseNo;
	
	//로그인 몇번했니
	private int frequencyLogin; 
	
	//남자여자 수
	public String manNo;
	public String womanNo;
	
	//공동구매 참여/미참여
	public String participation;
	public String nonParticipation;
	
}

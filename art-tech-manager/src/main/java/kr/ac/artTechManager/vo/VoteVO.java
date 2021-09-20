package kr.ac.artTechManager.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VoteVO {
	private String id;
	private String artworkInfoId;
	private int agreeNo; //매각 찬성 수 
	private int totalNo; //전체 수
	private String regDate;
	private String startDate;
	private String endDate;
	
	private String sellPlace; //매각처
	private String sellPrice; //매각 금액 
	private String state; //(0: 모집예정, 1: 모집중/2.모집완료/3: 매각 투표/4: 투표 종료/5. 매각 중/6: 수익 분배/7: 매각완료)
	private String url;
	private String writerName;
	private String title;
	private String type; //1. 투표  / 2. 투표 결과(매각) / 3. 투표결과(매각 기각) / 4. 매각대금 분배안내 / 5. 분배완료
	private String emailPw;
	private String targetPiece;
}

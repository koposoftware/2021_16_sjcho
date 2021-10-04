package kr.ac.artTechManager.vo;

import lombok.Data;

@Data
public class ArtworkInfoVO {
	private String id;
	private String title;
	private String writerId; //작가 ID
	private String material; //재료
	private String sizeWidth; //가로
	private String sizeHeight; //세로
	private String productionYear; //제작 연도
	private String artworkContent ; //작품 설명
	private String regDate ; //모집글 올린 날짜
	private String recruitStartDate;
	private String recruitEndDate;
	private String recruitStartTime; //모집 시작 시간
	private String recruitEndTime; //모집 종료 시간
	private String targetPiece; //공동구매 목표 조각 개수
	private String estimatedPriceMax ; //공동구매 작품 추정가 max
	private String estimatedPriceMin ; //공동구매 작품 추정가 min
	private String achiePiece; //달성 조각개수
	private String state; //상태(1.모집중, 2.모집완료, 3.매각투표, 4.투표종료, 5.매각중, 6.수익분배 7.매각완료)
	private String sellPrice; //매각금액
	private String totalTransferTax; //총 양도세
	private String sellDate; //매각일
	private String sellPlace; //매각처
	
	private String stateName;
	private String writerName;
	private String awardHistory;
	private String writerInfo;
	private String career;
	private String fileChanName;
	private String filePath;
	private String orgnFileName;
	private String artworkImg;
	
	
}

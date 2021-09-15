package kr.ac.arttech.member.vo;

import lombok.Data;

@Data
public class MyGalleryVO {
	private String artworkInfoId;
	private String totalPieceNo; //총 산 조각의 개수
	private String firstRegDate; //최초 구입일
	private String title;
	private String writerName;
	private String artworkImg;
	private String state; //진행현황(0: 모집예정, 1: 모집중/2.모집완료/3: 매각 투표/4: 투표 종료/5. 매각 중/6: 수익 분배/7: 매각완료)
}

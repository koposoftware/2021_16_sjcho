package kr.ac.arttech.cobuying.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PurchaseInfoVO {
	private String id;
	private String artworkInfoId;
	private String memberId;
	private int pieceNo; //조각 개수
	private String regDate;
	private String pieceAmt; //조각당 금액
	private String type ; //1.공동구매 2. 판매
	private String platformUsageFee; //6%
	private String vat; //부가세  0.6%
	private String transferTax; //양도세
	
	private String name; //member name
	private String totalPieceNo; //총 산 조각의 개수

}

package kr.ac.arttech.openbanking.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AutoTranAccountVO {
	private String id;
	private String memberId;
	private String bankCode;
	private String accountNumber;
	private String autoAmt;
	private String regDate;
	
	
	private String bankName;
	private String token;
	
	private List<String> accountArr;
	private List<String> bankNameArr;
	private List<String> bankCodeArr;
	private List<String> autoAmtArr;
	private String type;
}

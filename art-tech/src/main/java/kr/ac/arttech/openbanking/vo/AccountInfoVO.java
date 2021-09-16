package kr.ac.arttech.openbanking.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AccountInfoVO {
	private String accountNumber;
	private String accountPassword;
	private String balance;
	private String accountType;
	private String bankCode;
	private String bankName;
	private String juminNo;
	private String name;
	private String regDate;
	private String accountState;
	
	private String autoCheckYn;
}

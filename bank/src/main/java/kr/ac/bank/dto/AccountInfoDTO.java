package kr.ac.bank.dto;

import org.apache.ibatis.type.Alias;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("accountInfo")
public class AccountInfoDTO {
	private String accountNumber;
	private String accountPassword;
	private String balance;
	private String accountType;
	private String bankCode;
	private String juminNo;
	private String name;
	private String regDate;
	
	private String bankName;
	private String token;
}

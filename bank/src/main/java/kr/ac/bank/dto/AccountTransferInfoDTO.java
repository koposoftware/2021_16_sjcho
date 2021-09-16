package kr.ac.bank.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("accountTransferInfo")
public class AccountTransferInfoDTO {
	private String id;
	private String inoutType;
	private String tranAmt;
	private String tranDate;
	private String tranTime;
	private String accountNumber;
	private String bankCode;
	private String otherAccountNumber;
	private String otherBankCode;
	private String otherBankName;
	
	
	private String bankName;
	private String token;
	private String juminNo;
	private String name;
	
	//조건
	private String startDate;
	private String endDate;
	private String orderBy;
	private String selectInOutType; //입금or출금orall
	private String selectDepositYn; //예치금이면  Y, 아니면 N
}

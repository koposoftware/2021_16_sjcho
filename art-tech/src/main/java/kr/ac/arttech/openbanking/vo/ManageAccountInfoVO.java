package kr.ac.arttech.openbanking.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ManageAccountInfoVO {
	String id;
	String name;
	String juminNo;
	String accountNumber;
	String bankCode;
	String token;
	String regDate;
}

package kr.ac.bank.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Alias("member")
public class MemberInfoDTO {
	private String name;
	private String juminNo;
	private String token;
	private String id; //핀테크 이용번호
}

package kr.ac.bank.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("bankCode")
public class BankCodeDTO {
	public String bank_code;
	public String bank_name;
}

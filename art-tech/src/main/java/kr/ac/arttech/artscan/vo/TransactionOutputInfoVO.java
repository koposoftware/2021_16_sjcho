package kr.ac.arttech.artscan.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TransactionOutputInfoVO {
	private String id;
    private String artId;
    private String recipient;
    private float value;
    private String parentTransactionId;
}

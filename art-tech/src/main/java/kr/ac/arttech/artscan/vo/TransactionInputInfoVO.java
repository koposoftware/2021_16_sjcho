package kr.ac.arttech.artscan.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TransactionInputInfoVO {
	private String transactionOutputId;
    private TransactionOutputInfoVO UTXO;
}

package kr.ac.arttech.artscan.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReqTransactionVO {
	private String sendWallet;
    private String receiveWallet;
    private float value;
    private String artId;
}

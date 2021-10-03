package kr.ac.arttech.artscan.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WalletInfoVO {
	private String privateKey;
    private String publicKey;
}

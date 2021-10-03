package kr.ac.artcoin.dto;

import kr.ac.artcoin.core.Wallet;
import kr.ac.artcoin.utils.StringUtil;
import lombok.Data;

@Data
public class WalletInfo {

    private String privateKey;
    private String publicKey;

    public WalletInfo(Wallet wallet) {
        this.privateKey = StringUtil.getStringFromKey(wallet.privateKey);
        this.publicKey = StringUtil.getStringFromKey(wallet.publicKey);
    }
}

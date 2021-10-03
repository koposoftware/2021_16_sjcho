package kr.ac.arttech.artscan.vo;

import java.util.ArrayList;

import lombok.Data;


@Data
public class BlockInfoVO {
	private String hash;
    private String previousHash;
    private String merkleRoot;
    private ArrayList<TransactionInfoVO> transactions = new ArrayList<>();
    private long timeStamp;
    private int nonce;
    private int blockHeight;
}

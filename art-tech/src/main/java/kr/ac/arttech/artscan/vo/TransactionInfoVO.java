package kr.ac.arttech.artscan.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TransactionInfoVO {
	private String transactionId; //Contains a hash of transaction*
    private String artId;
    private String sender; //Senders address/public key.
    private String reciepient; //Recipients address/public key.
    private float value; //Contains the amount we wish to send to the recipient.
    private byte[] signature; //This is to prevent anybody else from spending funds in our wallet.
    private ArrayList<TransactionInputInfoVO> inputs ;
    private ArrayList<TransactionOutputInfoVO> outputs ;
}

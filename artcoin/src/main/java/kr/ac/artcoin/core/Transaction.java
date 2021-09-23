package kr.ac.artcoin.core;

import kr.ac.artcoin.blockchain.ArtChain;
import kr.ac.artcoin.utils.StringUtil;

import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.ArrayList;

public class Transaction {

    public String transactionId; //Contains a hash of transaction*
    public String artId;
    public PublicKey sender; //Senders address/public key.
    public PublicKey reciepient; //Recipients address/public key.
    public float value; //Contains the amount we wish to send to the recipient.
    public byte[] signature; //This is to prevent anybody else from spending funds in our wallet.

    public ArrayList<TransactionInput> inputs = new ArrayList<TransactionInput>();
    public ArrayList<TransactionOutput> outputs = new ArrayList<TransactionOutput>();

    private static int sequence = 0; //A rough count of how many transactions have been generated
    
    public Transaction() {
    }
    
    // Constructor:
    public Transaction(PublicKey from, PublicKey to, float value,  ArrayList<TransactionInput> inputs, String artId) {
        this.sender = from;
        this.reciepient = to;
        this.value = value;
        this.inputs = inputs;
        this.artId = artId;
    }
    
    //트랜잭션 수행
    public boolean processTransaction() {

        if(verifySignature() == false) {
            System.out.println("#Transaction Signature failed to verify");
            return false;
        }

        if (inputs == null) return true;

        //Gathers transaction inputs (Making sure they are unspent):
        for(TransactionInput i : inputs) {
            i.UTXO = ArtChain.UTXOs.get(i.transactionOutputId);
        }

        //트랜잭션 최소 값 확인
        //Checks if transaction is valid:
        if(getInputsValue() < ArtChain.minimumTransaction) {
            System.out.println("Transaction Inputs too small: " + getInputsValue());
            System.out.println("Please enter the amount greater than " + ArtChain.minimumTransaction);
            return false;
        }
        
        //트랜잭션 output 생성
        //Generate transaction outputs:
        float leftOver = getInputsValue() - value; //get value of inputs then the left over change:
        transactionId = calulateHash();
        outputs.add(new TransactionOutput( this.reciepient, value,transactionId, artId)); //send value to recipient 전송
        outputs.add(new TransactionOutput( this.sender, leftOver,transactionId, artId)); //send the left over 'change' back to sender 전송 후 남은 값
        
        //output값 UTXOs에 추가
        //Add outputs to Unspent list
        for(TransactionOutput o : outputs) {
            ArtChain.UTXOs.put(o.id , o);
        }

        //사용된 input 삭제
        //Remove transaction inputs from UTXO lists as spent:
        for(TransactionInput i : inputs) {
            if(i.UTXO == null) continue; //if Transaction can't be found skip it
            ArtChain.UTXOs.remove(i.UTXO.id);
        }

        return true;
    }

    //input값 조회
    public float getInputsValue() {
        float total = 0;
        for(TransactionInput i : inputs) {
            if(i.UTXO == null) continue; //if Transaction can't be found skip it, This behavior may not be optimal.
            total += i.UTXO.value;
        }
        return total;
    }

    //서명 생성
    public void generateSignature(PrivateKey privateKey) {
        String data = StringUtil.getStringFromKey(sender) + StringUtil.getStringFromKey(reciepient) + Float.toString(value)	;
        signature = StringUtil.applyECDSASig(privateKey,data);
    }
    
    //서명 검사
    public boolean verifySignature() {
        String data = StringUtil.getStringFromKey(sender) + StringUtil.getStringFromKey(reciepient) + Float.toString(value)	;
        return StringUtil.verifyECDSASig(sender, data, signature);
    }

    //output값 조회
    public float getOutputsValue() {
        float total = 0;
        for(TransactionOutput o : outputs) {
            total += o.value;
        }
        return total;
    }
    
    //해시 계산
    private String calulateHash() {
        sequence++; //increase the sequence to avoid 2 identical transactions having the same hash
        return StringUtil.applySha256(
                StringUtil.getStringFromKey(sender) +
                        StringUtil.getStringFromKey(reciepient) +
                        Float.toString(value) + sequence
        );
    }
}
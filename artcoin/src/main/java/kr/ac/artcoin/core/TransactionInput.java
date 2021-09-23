package kr.ac.artcoin.core;

public class TransactionInput {
    public String transactionOutputId; //Reference to TransactionOutputs -> transactionId
    public TransactionOutput UTXO; //Contains the Unspent transaction output, 사용되지 않은 트랜잭션 output들(unspent transaction output)

    public TransactionInput(String transactionOutputId) {
        this.transactionOutputId = transactionOutputId;
    }
}
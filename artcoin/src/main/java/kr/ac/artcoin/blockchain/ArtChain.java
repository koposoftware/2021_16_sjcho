package kr.ac.artcoin.blockchain;

import kr.ac.artcoin.core.Block;
import kr.ac.artcoin.core.Transaction;
import kr.ac.artcoin.core.TransactionInput;
import kr.ac.artcoin.core.TransactionOutput;
import kr.ac.artcoin.dto.ReqTransaction;

import java.util.ArrayList;
import java.util.HashMap;

public class ArtChain {

    public static ArrayList<Block> blockchain = new ArrayList<>();
    public static ArrayList<ReqTransaction> memPool = new ArrayList<>();
    public static HashMap<String, TransactionOutput> UTXOs = new HashMap<>();

    public static int BLOCKSIZE = 2;
    public static int difficulty = 3;
    public static float minimumTransaction = 0.1f;
    public static int BlockSequence = 0;
    
    //체인 유효성 검사
    public static Boolean isChainValid(Transaction transaction) {
        Block currentBlock;
        Block previousBlock;
        String hashTarget = new String(new char[difficulty]).replace('\0', '0');
        HashMap<String,TransactionOutput> tempUTXOs = new HashMap<>(); //a temporary working list of unspent transactions at a given block state.
        tempUTXOs.put(transaction.outputs.get(0).id, transaction.outputs.get(0));

        //loop through blockchain to check hashes:
        //블록 해시 값 검사
        for(int i=1; i < blockchain.size(); i++) {

            currentBlock = blockchain.get(i);
            previousBlock = blockchain.get(i-1);
            
            //compare registered hash and calculated hash:
            //현재 블록 해시 값 확인
            if(!currentBlock.hash.equals(currentBlock.calculateHash()) ){
                System.out.println("#Current Hashes not equal");
                return false;
            }
            
            //compare previous hash and registered previous hash
            //이전 블록 해시값 확인
            if(!previousBlock.hash.equals(currentBlock.previousHash) ) {
                System.out.println("#Previous Hashes not equal");
                return false;
            }
            
            //check if hash is solved
            //계산된 해시값 확인
            if(!currentBlock.hash.substring( 0, difficulty).equals(hashTarget)) {
                System.out.println("#This block hasn't been mined");
                return false;
            }

            //loop thru blockchains transactions:
            //트랜잭션 검사
            TransactionOutput tempOutput;
            for(int t=0; t <currentBlock.transactions.size(); t++) {
                Transaction currentTransaction = currentBlock.transactions.get(t);
                
                //서명 검증
                if(!currentTransaction.verifySignature()) {
                    System.out.println("#Signature on Transaction(" + t + ") is Invalid");
                    return false;
                }
                
                //인풋 값, 아웃 풋 값 확인
                if(currentTransaction.getInputsValue() != currentTransaction.getOutputsValue()) {
                    System.out.println("#Inputs are note equal to outputs on Transaction(" + t + ")");
                    return false;
                }

                for(TransactionInput input: currentTransaction.inputs) {
                    tempOutput = tempUTXOs.get(input.transactionOutputId);

                    if(tempOutput == null) {
                        System.out.println("#Referenced input on Transaction(" + t + ") is Missing");
                        return false;
                    }

                    if(input.UTXO.value != tempOutput.value) {
                        System.out.println("#Referenced input Transaction(" + t + ") value is Invalid");
                        return false;
                    }

                    tempUTXOs.remove(input.transactionOutputId);
                }

                for(TransactionOutput output: currentTransaction.outputs) {
                    tempUTXOs.put(output.id, output);
                }

                if( currentTransaction.outputs.get(0).recipient != currentTransaction.reciepient) {
                    System.out.println("#Transaction(" + t + ") output reciepient is not who it should be");
                    return false;
                }
                if( currentTransaction.outputs.get(1).recipient != currentTransaction.sender) {
                    System.out.println("#Transaction(" + t + ") output 'change' is not sender.");
                    return false;
                }

            }

        }
        System.out.println("Blockchain is valid");
        return true;
    }
    
    //블록 생성
    public static void addBlock(Block newBlock) {
    	newBlock.blockHeight = ++BlockSequence;
        newBlock.mineBlock(difficulty);
        blockchain.add(newBlock);
    }
}
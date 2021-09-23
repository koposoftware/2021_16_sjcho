package kr.ac.artcoin.core;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

import kr.ac.artcoin.blockchain.ArtChain;

import java.security.*;
import java.security.spec.ECGenParameterSpec;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Wallet2 {

    public PrivateKey privateKey;
    public PublicKey publicKey;

    public HashMap<String,TransactionOutput> UTXOs = new HashMap<String,TransactionOutput>();

    //객체 생성 시 키 생성
    public Wallet2() {
        generateKeyPair();
    }

    public void generateKeyPair() {
        try {
            Security.addProvider(new BouncyCastleProvider());
            KeyPairGenerator keyGen = KeyPairGenerator.getInstance("ECDSA","BC");
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
            ECGenParameterSpec ecSpec = new ECGenParameterSpec("prime192v1");
            // Initialize the key generator and generate a KeyPair
            keyGen.initialize(ecSpec, random); //256
            KeyPair keyPair = keyGen.generateKeyPair();
            // Set the public and private keys from the keyPair
            privateKey = keyPair.getPrivate();
            publicKey = keyPair.getPublic();
        }catch(Exception e) {
            throw new RuntimeException(e);
        }
    }

    //지갑 조회
    public Map<String, Float> getBalance() {
        Map<String, Float> balance = new HashMap<>();
        for (Map.Entry<String, TransactionOutput> item: ArtChain.UTXOs.entrySet()){
            TransactionOutput UTXO = item.getValue();
            if(UTXO.isMine(publicKey)) {
                UTXOs.put(UTXO.id,UTXO);
                float v = balance.get(UTXO.artId) == null ? UTXO.value : balance.get(UTXO.artId) + UTXO.value;
                balance.put(UTXO.artId, v);
            }
        }
        return balance;
    }

    //송금
    public Transaction sendFunds(PublicKey _recipient, float value, String artId) {
        if(getBalance().get(artId) < value) {
            System.out.println("#Not Enough funds to send transaction. Transaction Discarded.");
            return null;
        }
        ArrayList<TransactionInput> inputs = new ArrayList<TransactionInput>();

        float total = 0;
        for (Map.Entry<String, TransactionOutput> item: UTXOs.entrySet()){
            TransactionOutput UTXO = item.getValue();
            System.out.println(UTXO.artId);
            if (UTXO.artId.equals(artId)) {
                total += UTXO.value;
                inputs.add(new TransactionInput(UTXO.id));
                if(total > value) break;
            }
        }

        Transaction newTransaction = new Transaction(publicKey, _recipient , value, inputs, artId);
        newTransaction.generateSignature(privateKey);

        for(TransactionInput input: inputs){
            UTXOs.remove(input.transactionOutputId);
        }

        return newTransaction;
    }

}

package kr.ac.artcoin.core;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

import kr.ac.artcoin.blockchain.ArtChain;

import java.security.*;
import java.security.spec.ECGenParameterSpec;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Wallet {

    public PrivateKey privateKey;
    public PublicKey publicKey;

    public HashMap<String,TransactionOutput> UTXOs = new HashMap<String,TransactionOutput>();

    //객체 생성 시 키 생성
    public Wallet() {
        generateKeyPair();
    }

    public void generateKeyPair() {
        try {
            Security.addProvider(new BouncyCastleProvider());
            //KeyPairGenerator 클래스는 공개키와 비공개키의 페어를 생성하기 위해서 사용
            //타원 곡선을 특정한 알고리즘(ECDSA)을 적용해 키를 생성
            KeyPairGenerator keyGen = KeyPairGenerator.getInstance("ECDSA","BC");
            //SecureRandom : 예측할 수 없는 seed를 이용하여 난수를 생성
            //SHA1PRNG 알고리즘을 사용
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
            //ECGenParameterSpec :해당 (미리 계산 된) 타원 곡선 도메인 매개 변수를 생성하기 위해 
            //표준 (또는 미리 정의 된) 이름 stdName 을 사용하여 EC 매개 변수 생성을위한 매개 변수 사양 을 생성
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
                float v = balance.get(UTXO.artId) == null ? UTXO.value : balance.get(UTXO.artId) + UTXO.value; //잔액 더해주기
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

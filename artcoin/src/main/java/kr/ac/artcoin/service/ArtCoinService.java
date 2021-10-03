package kr.ac.artcoin.service;

import kr.ac.artcoin.blockchain.ArtChain;
import kr.ac.artcoin.core.Block;
import kr.ac.artcoin.core.Transaction;
import kr.ac.artcoin.core.TransactionOutput;
import kr.ac.artcoin.core.Wallet;
import kr.ac.artcoin.dto.*;
import kr.ac.artcoin.exception.ArtChainException;
import kr.ac.artcoin.repository.WalletRepository;
import kr.ac.artcoin.utils.StringUtil;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ArtCoinService {

    private final WalletRepository walletRepository;

    public WalletInfo createWallet() {
        Wallet wallet = walletRepository.createWallet();
        return new WalletInfo(wallet);
    }

    public void transaction(ReqTransaction reqTransaction) {
    	
    	// 요청 트랜잭션 유효성 검사
        if (reqTransaction == null || !isTransactionValid(reqTransaction)) {
            throw new ArtChainException("transaction is not valid");
        }
    	
    	//블록생성 (블록사이즈 다 차면)
        if (ArtChain.memPool.size() == ArtChain.BLOCKSIZE) {
            Block block = new Block(ArtChain.blockchain.get(ArtChain.blockchain.size() - 1).hash);
            ArtChain.memPool.forEach(tx -> {
                try {
                    Wallet sendWallet = walletRepository.findWallet(tx.getSendWallet());
                    Wallet receiveWallet = walletRepository.findWallet(tx.getReceiveWallet());
                    
                    Transaction transaction = sendWallet.sendFunds(receiveWallet.publicKey, tx.getValue(), tx.getArtId());
                    block.addTransaction(transaction);
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            });
            ArtChain.addBlock(block);
            ArtChain.memPool.clear();
        }
        ArtChain.memPool.add(reqTransaction);
    }

    // 트랜잭션 유효성 검사
    private boolean isTransactionValid(ReqTransaction reqTransaction) {
        Wallet receiveWallet = walletRepository.findWallet(reqTransaction.getReceiveWallet());
        Wallet sendWallet = walletRepository.findWallet(reqTransaction.getSendWallet());
        return receiveWallet != null && sendWallet != null && sendWallet.getBalance().get(reqTransaction.getArtId()) >= reqTransaction.getValue();
    }
    
    //지갑 조회
    public Map<String, Float> getBalance(String address) {
    	address = address.replace(" ", "+");
        Wallet wallet = walletRepository.findWallet(address);
        return wallet.getBalance();
    }

    //모든 트랜잭션 조회 
    public List<TransactionDto.TransactionInfo> getTransactions() {
        List<TransactionDto.TransactionInfo> transactions = new ArrayList<>();
        ArtChain.blockchain.forEach(block -> {
        	int blockHeight = block.blockHeight;
        	String blockHash = block.hash;
            transactions.addAll(block.transactions.stream().map(tx -> {
            	TransactionDto.TransactionInfo txInfo = new TransactionDto.TransactionInfo(tx);
            	txInfo.setBlockHeight(blockHeight);
            	txInfo.setBlockHash(blockHash);
            	return txInfo;
            }).collect(Collectors.toList()));
        });
        return transactions;
    }
    
    //특정 wallet, art id 트랜잭션 조회
    public List<TransactionDto.TransactionInfo> getOptionTransactions(ReqTransaction reqTransaction) {
    	reqTransaction.setReceiveWallet(reqTransaction.getReceiveWallet().replace(" ", "+"));
    	List<TransactionDto.TransactionInfo> transactions = new ArrayList<>();
    	ArtChain.blockchain.forEach(block -> {
    		int blockHeight = block.blockHeight;
    		String blockHash = block.hash;
    		block.transactions.forEach(tx -> {
    			if(StringUtil.getStringFromKey(tx.reciepient).equals(reqTransaction.getReceiveWallet()) 
    					&& tx.artId.equals(reqTransaction.getArtId())) {
    				TransactionDto.TransactionInfo txInfo = new TransactionDto.TransactionInfo(tx);
    				txInfo.setBlockHash(blockHash);
    				txInfo.setBlockHeight(blockHeight);
    				transactions.add(txInfo);
    			}
    		});
    		
    	});
    	return transactions;
    }

    //모든 블록 조회
    public ArtChainInfo getBlocks() {
        List<BlockInfo> blocks = ArtChain.blockchain.stream().map(BlockInfo::new).collect(Collectors.toList());
        return ArtChainInfo.builder()
                .blocks(blocks)
                .totalBlockSize(blocks.size())
                .build();
    }

    //미술품 추가 (새로운 블록 생성)
    public String addArt(ReqAddArt reqAddArt) {
        Wallet coinbase = WalletRepository.coinbase;
        Wallet admin = WalletRepository.admin;
        Transaction artTransaction = new Transaction(coinbase.publicKey, admin.publicKey, reqAddArt.getValue(), null, reqAddArt.getArtId());
        artTransaction.generateSignature(coinbase.privateKey);
        artTransaction.transactionId = "0";
        artTransaction.outputs.add(new TransactionOutput(artTransaction.reciepient, artTransaction.value, artTransaction.transactionId, artTransaction.artId));

        ArtChain.UTXOs.put(artTransaction.outputs.get(0).id, artTransaction.outputs.get(0));
        Block block = null;

        if(ArtChain.blockchain.size() == 0) { //블록체인에 아무 것도 없는 경우
        	block = new Block("0"); //최초 블록 생성
        } else { //있을 경우에
        	block = new Block(ArtChain.blockchain.get(ArtChain.blockchain.size()-1).hash); //블록 생성
        }
        
        if (block.addTransaction(artTransaction)) { //블록체인에 해당 블록 추가(즉, 작품 등록시 1개의 트랜잭션만 있는 블록이 생성)
            ArtChain.addBlock(block);
        } else {
            throw new ArtChainException("block generated fail");
        }
        return block.hash;
    }
    
    //트랜잭션 id로 조회 
    public TransactionDto.TransactionInfo getTransaction(String transactionHash) {
        ArrayList<Block> blockchain = ArtChain.blockchain;
        Transaction tx;
        for (Block block : blockchain) {
            for (Transaction transaction : block.transactions) {
                if (transaction.transactionId.equals(transactionHash)) {
                	int blockHeight = block.blockHeight;
                	String blockHash = block.hash;
                	tx = transaction;
                	TransactionDto.TransactionInfo txInfo = new TransactionDto.TransactionInfo(tx);
                	txInfo.setBlockHeight(blockHeight);
                	txInfo.setBlockHash(blockHash);
                    return txInfo;
                }
            }
        }
        throw new ArtChainException("transactionId not found");
    }
    
    //블록 hash로 조회
    public BlockInfo getBlock(String hash) {
    	ArrayList<Block> blockchain = ArtChain.blockchain;
    	Block blockInfo;
    	for(Block block : blockchain) {
    		if(block.hash.equals(hash)) {
    			blockInfo = block;
    			return new BlockInfo(blockInfo);
    		}
    	}
    	throw new ArtChainException("BlockId not found");
    }


}

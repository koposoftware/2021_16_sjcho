package kr.ac.artcoin.controller;

import kr.ac.artcoin.blockchain.ArtChain;
import kr.ac.artcoin.core.Wallet;
import kr.ac.artcoin.dto.ReqAddArt;
import kr.ac.artcoin.dto.ReqTransaction;
import kr.ac.artcoin.dto.Response;
import kr.ac.artcoin.dto.TransactionDto;
import kr.ac.artcoin.repository.WalletRepository;
import kr.ac.artcoin.service.ArtCoinService;
import kr.ac.artcoin.utils.StringUtil;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class ArtCoinController {

    private final ArtCoinService artCoinService;
    
    // 지갑 생성
    @PostMapping("/wallet")
    public Response<?> createWallet() {
        return Response.builder()
                .code(1)
                .msg("success")
                .data(artCoinService.createWallet())
                .build();
    }

    // 트랜잭션 id 로 조회
    @GetMapping("/transaction")
    public Response<?> getTransaction(String transactionHash) {
        return Response.builder()
                .code(1)
                .msg("success")
                .data(artCoinService.getTransaction(transactionHash))
                .build();
    }

    // 트랜잭션 요청(생성) - 사용자가 미술품 구매했을 경우 
    @PostMapping("/transaction")
    public Response<?> requestTransaction(@RequestBody ReqTransaction reqTransaction) {
    	reqTransaction.setSendWallet(StringUtil.getStringFromKey(WalletRepository.admin.publicKey));
        artCoinService.transaction(reqTransaction);
        return Response.builder()
                .code(1)
                .msg("success")
                .build();
    }

    // 지갑 조회 (return 잔액)
    @GetMapping("/wallet")
    public Response<?> getBalance(String address) {
        return Response.builder()
                .code(1)
                .msg("success")
                .data(artCoinService.getBalance(address))
                .build();
    }

    // 모든 블록 조회
    @GetMapping("/blocks")
    public Response<?> getBlocks() {
        return Response.builder()
                .code(1)
                .msg("success")
                .data(artCoinService.getBlocks())
                .build();
    }
    
    //블록 id로 조회
    @GetMapping("/block")
    public Response<?> getBlock(String hash) {
    	return Response.builder()
                .code(1)
                .msg("success")
                .data(artCoinService.getBlock(hash))
                .build();
    }

    // utxo 조회
    @GetMapping("/utxos")
    public Response<?> getUTXOs() {
        return Response.builder()
                .code(1)
                .msg("success")
                .data(ArtChain.UTXOs)
                .build();
    }

    // 모든 트랜잭션 조회
    @GetMapping("/transactions")
    public Response<?> getTransactions() {
        return Response.builder()
                .code(1)
                .msg("success")
                .data(artCoinService.getTransactions())
                .build();
    }
    
    //특정 wallet, art id의 트랜잭션 list
    @GetMapping("/optionTransactions")
    public Response<?> getOptionTransactions(ReqTransaction reqTransaction) {
    	System.out.println("컨트롤러 : " + reqTransaction);
        return Response.builder()
                .code(1)
                .msg("success")
                .data(artCoinService.getOptionTransactions(reqTransaction))
                .build();
    }
    
    // 미술품 추가
    @PostMapping("/art")
    public Response<?> addArt(@RequestBody ReqAddArt reqAddArt) {
        return Response.builder()
                .code(1)
                .msg("success")
                .data(artCoinService.addArt(reqAddArt))
                .build();
    }
    
   
}

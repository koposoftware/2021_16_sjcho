package kr.ac.bank.controller;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.bank.dto.AccountInfoDTO;
import kr.ac.bank.dto.AccountTransferInfoDTO;
import kr.ac.bank.dto.MemberInfoDTO;
import kr.ac.bank.dto.Response;
import kr.ac.bank.service.BankService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class BankController {
	private final BankService service;
	
	//토큰 생성
	@PostMapping("/newToken")
	public Response<?> createToken(@RequestBody String nameJuminNo) {
		return Response.builder()
				.code(1)
				.msg("sucess")
				.data(service.createToken(nameJuminNo))
				.build();
	}
	
	//계좌 리스트 가져오기
	@PostMapping("/accountList")
	public Response<?> getAccountList(@RequestBody MemberInfoDTO memberInfoDTO) {
		return Response.builder()
				.code(1)
				.msg("sucess")
				.data(service.getAccountList(memberInfoDTO))
				.build();
	}
	
	//특정 계좌의 정보 가져오기
	@PostMapping("/accountInfo")
	public Response<?> getAccountInfo(@RequestBody Map<String, String> map) {
		return Response.builder()
				.code(1)
				.msg("sucess")
				.data(service.getAccount(map))
				.build();
	}
	
	//거래내역 조회
	@PostMapping("/tranInfo")
	public Response<?> getAccountTransferInfo(@RequestBody AccountTransferInfoDTO tranInfo) {
		return Response.builder()
				.code(1)
				.msg("sucess")
				.data(service.getTranInfoList(tranInfo))
				.build();
	}
	
	//예치금 총 금액 가져오기
	@PostMapping("/totalDeposit")
	public Response<?> getTotalDeposit(@RequestBody String token) {
		return Response.builder()
				.code(1)
				.msg("sucess")
				.data(service.getTotalDeposit(token))
				.build();
	}
	
	//자동이체 진행하기
	@PostMapping("/tran")
	public Response<?> startTran(@RequestBody List<AccountTransferInfoDTO> accountTranInfoList) {
		return Response.builder()
				.code(1)
				.msg("sucess")
				.data(service.addTranInfo(accountTranInfoList))
				.build();
	}
	
}

package kr.ac.bank.service;


import java.util.List;
import java.util.Map;

import kr.ac.bank.dto.AccountInfoDTO;
import kr.ac.bank.dto.AccountTransferInfoDTO;
import kr.ac.bank.dto.MemberInfoDTO;


public interface BankService {
	
	//토큰 생성
	public String createToken(String nameJuminNo);
	
	//계좌리스트
	public List<AccountInfoDTO> getAccountList(MemberInfoDTO memberInfoDTO); 
	
	//특정 계좌 정보
	public List<AccountInfoDTO> getAccount(Map<String, String> map);
	
	//거래내역
	public List<AccountTransferInfoDTO> getTranInfoList(AccountTransferInfoDTO tranInfo);
	
	//총 예치금
	public String getTotalDeposit(String token);
	
	//이체
	public String addTranInfo(List<AccountTransferInfoDTO> accountTranInfoList );
}

package kr.ac.arttech.openbanking.service;

import java.util.List;

import kr.ac.arttech.openbanking.vo.AccountInfoVO;
import kr.ac.arttech.openbanking.vo.AccountTransferInfoVO;
import kr.ac.arttech.openbanking.vo.AutoTranAccountVO;

public interface OpenBankingService {
	public boolean checkServiceAgree(String memberId); //오픈뱅킹 동의 확인
	public boolean changeServiceAgreeState(String memberId); //오픈뱅킹 동의
	
	public List<AccountInfoVO> getAccountInfoList(String memberId); //오픈뱅킹에서 나의 계좌 리스트 가져오기
	
	//은행api에서 해당 계좌 정보 가져오기
	public List<AccountInfoVO> getAccountInfo(String memberId, AccountInfoVO accountInfo); 
	
	//거래내역 가져오기
	public List<AccountTransferInfoVO> getTranInfoList(String memberId, AccountTransferInfoVO tranInfo);
	
	public List<AutoTranAccountVO> getAutoAccountList(String memberId); //자동 예치금 설정한 계좌
	public boolean setAutoAccount(AutoTranAccountVO autoTranAccountVO, String memberId); //자동이체 설정 or 취소
	
	//자동 예치금 설정 안한 계좌 가져오기
	public List<AccountInfoVO> getNonAutoAccountList(String memberId);
	
	//예치금 총 금액 가져오기
	public String getDeposit(String memberId);
	
	//자동으로 예치금 충전
	public boolean startAutoTranDeposit();
	
	//토큰 가져오기
	public String getToken(String memberId) ;
	
	//계좌이체
	public boolean addTranInfo(AccountTransferInfoVO tranInfo);
	
}

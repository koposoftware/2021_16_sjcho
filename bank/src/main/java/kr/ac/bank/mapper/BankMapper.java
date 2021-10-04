package kr.ac.bank.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.ac.bank.dto.AccountInfoDTO;
import kr.ac.bank.dto.AccountTransferInfoDTO;
import kr.ac.bank.dto.MemberInfoDTO;

@Mapper
public interface BankMapper {
	
	//한명의 계좌 리스트 가져오기
	public List<AccountInfoDTO> selectAccountInfoList(MemberInfoDTO memberInfoDTO);
	
	//한개 계좌 정보 가져오기
	public AccountInfoDTO selectAccountInfo(Map<String, String> map);
	
	//거래내역 가져오기
	public List<AccountTransferInfoDTO> selectTranInfoList(AccountTransferInfoDTO tranInfo);
	
	//총 예치금 금액
	public String selectTotalDeposit(String fintechNo);
	
	//거래내역 테이블 시퀀스 가져오기
	public int selectAccountTranInfoSeq();
	
	//거래내역 insert
	public int insertAccountTranInfo(AccountTransferInfoDTO accountTranInfo);
	
	//오픈뱅킹 table update
	public int updateAuthAgree(String phone);
	//오픈뱅킹 table id 가져오기
	public String selectOpenbankingSeq(String phone);
	//오픈뱅킹 주민, 이름 정보 가져오기
	public MemberInfoDTO getMemberInfo(String id);
}

package kr.ac.bank.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import kr.ac.bank.dto.AccountInfoDTO;
import kr.ac.bank.dto.AccountTransferInfoDTO;
import kr.ac.bank.dto.MemberInfoDTO;
import kr.ac.bank.mapper.BankMapper;
import kr.ac.bank.util.SecurityUtil;
import kr.ac.bank.util.Token;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BankServiceImpl implements BankService{
	private final BankMapper mapper;
	
	//토큰 생성
	@Override
	public String createToken(String nameJuminNo) {
		String decryptData = "";
		try {
			decryptData = new SecurityUtil().decryptAES256(nameJuminNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		MemberInfoDTO memberInfoDTO = new MemberInfoDTO();
		memberInfoDTO.setName(decryptData.split(":")[0]);
		memberInfoDTO.setJuminNo(decryptData.split(":")[1]);
		return Token.createToken(memberInfoDTO);
	}
	
	//한명의 계좌 리스트
	@Override
	public List<AccountInfoDTO> getAccountList(MemberInfoDTO memberInfoDTO) {
		List<AccountInfoDTO> getAccountList = null;
		if(Token.checkExpToken(memberInfoDTO)) {
			//정보 가져오기
			memberInfoDTO.setName(Token.getName(memberInfoDTO));
			memberInfoDTO.setJuminNo(Token.getJuminNo(memberInfoDTO));
			
			getAccountList = mapper.selectAccountInfoList(memberInfoDTO);
		}
		
		return getAccountList;
	}
	
	//특정 계좌 정보
	@Override
	public List<AccountInfoDTO> getAccount(Map<String, String> map) {
		List<AccountInfoDTO> accountInfoList = new ArrayList<AccountInfoDTO>();
		MemberInfoDTO memberInfoDTO = new MemberInfoDTO();
		memberInfoDTO.setToken(map.get("token"));
		
		if(Token.checkExpToken(memberInfoDTO) ) {
			//정보 가져오기
			map.put("juminNo", Token.getJuminNo(memberInfoDTO));
			map.put("name", Token.getName(memberInfoDTO));
			
			accountInfoList.add(mapper.selectAccountInfo(map));
		}
		
		return accountInfoList;
	}
	
	//거래내역 가져오기
	@Override
	public List<AccountTransferInfoDTO> getTranInfoList(AccountTransferInfoDTO tranInfo) {
		List<AccountTransferInfoDTO> tranInfoList = null;
		
		MemberInfoDTO memberInfoDTO = new MemberInfoDTO();
		memberInfoDTO.setToken(tranInfo.getToken());
		
		if(Token.checkExpToken(memberInfoDTO) ) {
			tranInfoList = mapper.selectTranInfoList(tranInfo);
		}
		
		return tranInfoList;
	}
	
	//총 예치금
	@Override
	public String getTotalDeposit(String token) {
		String paramToken = "";
		try {
			JSONObject jObject = new JSONObject(token);
			paramToken = jObject.getString("token");
			
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		String total = "";
		MemberInfoDTO memberInfoDTO = new MemberInfoDTO();
		memberInfoDTO.setToken(paramToken);
		
		if(Token.checkExpToken(memberInfoDTO) ) {
			//정보 가져오기
			total = mapper.selectTotalDeposit(paramToken);
		}
		
		return total;
	}
	
	//이체 
	@Override
	public String addTranInfo(List<AccountTransferInfoDTO> accountTranInfoList) {
		String result = "fail";
		
		//dao로 가져갈 파라미터 생성
		List<AccountTransferInfoDTO> param = new ArrayList<>();
		
		int cnt = 0;
		for(AccountTransferInfoDTO accountTranInfo : accountTranInfoList) {
			//토큰 유효한지 확인
			MemberInfoDTO memberInfoDTO = new MemberInfoDTO();
			memberInfoDTO.setToken(accountTranInfo.getToken());
			
			if(Token.checkExpToken(memberInfoDTO) ) {
				//정보 가져오기
				String id = "transfer" + mapper.selectAccountTranInfoSeq(); //시퀀스값 가져오기
				
				//추가 정보 넣기
				accountTranInfo.setId(id);
				accountTranInfo.setJuminNo(Token.getJuminNo(memberInfoDTO));
				accountTranInfo.setName(Token.getName(memberInfoDTO));
				
				//이체 테이블에 insert
				cnt += mapper.insertAccountTranInfo(accountTranInfo);
				
			}
			
		}
		
		if(cnt == accountTranInfoList.size()) {
			result = "success";
		}
		
		
		return result;
	}
	
}

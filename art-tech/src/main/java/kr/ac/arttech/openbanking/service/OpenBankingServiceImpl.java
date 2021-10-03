package kr.ac.arttech.openbanking.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;

import kr.ac.arttech.cobuying.dao.CobuyingDAO;
import kr.ac.arttech.member.vo.MemberVO;
import kr.ac.arttech.openbanking.dao.OpenBankingDAO;
import kr.ac.arttech.openbanking.vo.AccountInfoVO;
import kr.ac.arttech.openbanking.vo.AccountTransferInfoVO;
import kr.ac.arttech.openbanking.vo.AuthenticationResponse;
import kr.ac.arttech.openbanking.vo.AutoTranAccountVO;
import kr.ac.arttech.openbanking.vo.AutoTranInfoSMSVO;
import kr.ac.arttech.openbanking.vo.ManageAccountInfoVO;
import kr.ac.arttech.util.AutoTranInfoSMS;
import kr.ac.arttech.util.SecurityUtil;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OpenBankingServiceImpl implements OpenBankingService {
	
	private final OpenBankingDAO dao;
	private final CobuyingDAO cobuyingDao;
	
	//오픈뱅킹 동의했는지 확인
	@Override
	public boolean checkServiceAgree(String memberId) {
		
		boolean result = false;
		String agreeCheck = dao.checkServiceAgree(memberId);
		
		if(agreeCheck.equals("Y")) {
			result = true;
		}
		
		return result;
	}
	
	
	@Override
	public boolean changeServiceAgreeState(String memberId) {
		
		//주민번호랑 이름 가져오기
		MemberVO member = dao.selectMemberNameJumin(memberId);
		
		String nameJuminNo = member.getName() + ":" + member.getJuminNo();
		String encryptData = "";
		
		try {
			encryptData = new SecurityUtil().encryptAES256(nameJuminNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		String url = "http://localhost:18081/newToken";
		RestTemplate restTemplate = new RestTemplate();
		Map<String, String> data = (Map<String, String>) restTemplate.postForObject(url,encryptData, Object.class);
		
		String token = data.get("data");
		
		member.setId(memberId);
		member.setToken(token);
		
		//(Y로 바꾸고, 토큰 추가)
		int update = dao.updateServiceAgreeState(member);
		
		boolean result = false;
		if(update == 1) { //성공했을 때 (db넣기)
			result = true;
		}
		
		return result;
	}
	
	//나의 계좌 리스트 가져오기 
	@Override
	public List<AccountInfoVO> getAccountInfoList(String memberId) {
		List<AccountInfoVO> accountInfo = null;
		
		//토큰 가져오기
		String token = dao.selectToken(memberId);
		
		//토큰과 핀테크 이용번호로 은행 api로 계좌리스트 가져오기
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JsonObject parameters = new	JsonObject();
		parameters.addProperty("token", token);
		HttpEntity<Object> entity = new HttpEntity<Object>(parameters.toString(), headers);
		
		String url = "http://localhost:18081/accountList";
		RestTemplate restTemplate = new RestTemplate();
		Map<String, Object> data = (Map<String, Object>) restTemplate.postForObject(url, entity, Object.class);
		
		accountInfo = (List<AccountInfoVO>) data.get("data");
		
		return accountInfo;
	}
	
	
	//은행api에서 해당 계좌 정보 가져오기(디테일)
	@Override
	public List<AccountInfoVO> getAccountInfo(String memberId, AccountInfoVO accountInfo) {
		List<AccountInfoVO> result = null;
		
		
		//토큰 가져오기
		String token = dao.selectToken(memberId);
		
		//토큰으로 은행 api에서 특정 계좌 정보 가져오기
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JsonObject parameters = new	JsonObject();
		parameters.addProperty("token", token);
		parameters.addProperty("accountNumber", accountInfo.getAccountNumber());
		parameters.addProperty("bankCode", accountInfo.getBankCode());
		
		
		HttpEntity<Object> entity = new HttpEntity<Object>(parameters.toString(), headers);
		
		String url = "http://localhost:18081/accountInfo";
		RestTemplate restTemplate = new RestTemplate();
		Map<String, Object> data = (Map<String, Object>) restTemplate.postForObject(url,entity, Object.class);
		
		result = (List<AccountInfoVO>) data.get("data");
		
		return result;
	}
	
	//거래내역 가져오기
	@Override
	public List<AccountTransferInfoVO> getTranInfoList(String memberId, 
			AccountTransferInfoVO tranInfo) {
		List<AccountTransferInfoVO> tranInfoList = null;
		
		//토큰 가져오기
		String token = dao.selectToken(memberId);
		
		
		//토큰으로 은행 api에서 특정 계좌의 거래내역 가져오기
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JsonObject parameters = new	JsonObject();
		parameters.addProperty("accountNumber", tranInfo.getAccountNumber());
		parameters.addProperty("bankCode", tranInfo.getBankCode());
		parameters.addProperty("token", token);
		parameters.addProperty("startDate", tranInfo.getStartDate());
		parameters.addProperty("endDate", tranInfo.getEndDate());
		parameters.addProperty("orderBy", tranInfo.getOrderBy());
		parameters.addProperty("selectInOutType", tranInfo.getSelectInOutType());
		parameters.addProperty("selectDepositYn", tranInfo.getSelectDepositYn());
		
		HttpEntity<Object> entity = new HttpEntity<Object>(parameters.toString(), headers);
		
		String url = "http://localhost:18081/tranInfo";
		RestTemplate restTemplate = new RestTemplate();
		Map<String, Object> data = (Map<String, Object>) restTemplate.postForObject(url,entity, Object.class);
		
		tranInfoList = (List<AccountTransferInfoVO>) data.get("data");
		
		return tranInfoList;
	}
	
	
	//자동예치금 설정한 계좌
	@Override
	public List<AutoTranAccountVO> getAutoAccountList(String memberId) {
		return dao.selectAutoAccountList(memberId);
	}
	
	//자동 예치금 이체 설정 안한 계좌
	@Override
	public List<AccountInfoVO> getNonAutoAccountList(String memberId) {
		
		Map<String, String> map = new HashMap<>();
		map.put("juminNo", dao.selectJuminNo(memberId));
		map.put("memberId", memberId);
		
		return dao.selectNonAutoAccountList(map);
	}
	
	//자동이체 설정 or 취소
	@Override
	public boolean setAutoAccount(AutoTranAccountVO autoTranAccountVO, String memberId) {
		
		boolean result = false;
		
		String type = autoTranAccountVO.getType();
		
		Map<String, Object> paramMap = new HashMap<>();
		
		List<Map<String, String>> list = new ArrayList<>();
		List<String> accountList = new ArrayList<>();
		
		int cnt = 0;
		
		if(type.equals("auto")) { //insert
			for(int i = 0; i < autoTranAccountVO.getAccountArr().size(); ++i) {
				Map<String, String> map = new HashMap<>();
				map.put("id", "auto" + dao.selectSeqNo());
				map.put("accountNumber", autoTranAccountVO.getAccountArr().get(i));
				map.put("bankCode", autoTranAccountVO.getBankCodeArr().get(i));
				map.put("bankName", autoTranAccountVO.getBankNameArr().get(i));
				map.put("autoAmt", autoTranAccountVO.getAutoAmtArr().get(i));
				map.put("memberId", memberId);
				list.add(map);
			}
			paramMap.put("paramMap", list);
			cnt = dao.insertAutoAccountInfo(paramMap);
			
		}else { //delete
			for(int i = 0; i < autoTranAccountVO.getAccountArr().size(); ++i) {
				accountList.add(autoTranAccountVO.getAccountArr().get(i));
			}
			paramMap.put("paramMap", accountList);
			cnt = dao.deleteAutoAccountInfo(paramMap);
		}
		
		if(cnt > 0) {
			result = true;
		}
		
		return result;
	}
	
	//예치금 총 금액 가져오기 (미술품 산거 안뺀거임 아직)
	@Override
	public String getDeposit(String memberId) {
		String result = "";
		
		//토큰 가져오기
		String token = dao.selectToken(memberId);
		
		//토큰으로 은행 api에서 예치금 총 금액 가져오기
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JsonObject parameters = new	JsonObject();
		parameters.addProperty("token", token);
		
		HttpEntity<Object> entity = new HttpEntity<Object>(parameters.toString(), headers);
		
		String url = "http://localhost:18081/totalDeposit";
		RestTemplate restTemplate = new RestTemplate();
		//Map<String, Object> data = (Map<String, Object>) restTemplate.postForObject(url,entity, Object.class);
		Map<String, Object> data = (Map<String, Object>) restTemplate.postForObject(url,entity, Object.class);
		
		String totalDeposit = (String) data.get("data"); 
		//미술품 산 거 빼야지
		String totalPurchaseAmt = cobuyingDao.selectTotalPurchaseAmt(memberId);
		
		long resultInt = Long.parseLong(totalDeposit) - Long.parseLong(totalPurchaseAmt);
		DecimalFormat decFormat = new DecimalFormat("###,###");
		result = decFormat.format(resultInt);
		
		return result;
	}
	
	
	//자동으로 예치금 충전
	@Override
	public boolean startAutoTranDeposit() {
		boolean result = false;
		//자동으로 이체할 list 가져오기
		List<AutoTranAccountVO> autoAccountInfoList = dao.selectAutoTranAccountInfoList();
		
		//회사 계좌 정보 가져오기
		ManageAccountInfoVO manageAccountInfo = dao.selectManageAccountInfo();
		
		//param 담기
		List<AccountTransferInfoVO> accountTranInfoList = new ArrayList<>(); 
		
		autoAccountInfoList.forEach(autoAccountInfo -> {
			AccountTransferInfoVO accountTranInfo = new AccountTransferInfoVO();
			
			//출금(유저 기준)
			
			accountTranInfo.setInoutType("O");
			accountTranInfo.setTranAmt(autoAccountInfo.getAutoAmt());
			accountTranInfo.setAccountNumber(autoAccountInfo.getAccountNumber());
			accountTranInfo.setBankCode(autoAccountInfo.getBankCode());
			accountTranInfo.setOtherAccountNumber(manageAccountInfo.getAccountNumber());
			accountTranInfo.setOtherBankCode(manageAccountInfo.getBankCode());
			accountTranInfo.setToken(autoAccountInfo.getToken());
			accountTranInfoList.add(accountTranInfo);
			
			accountTranInfo = new AccountTransferInfoVO();
			//입금(회사 기준)
			accountTranInfo.setInoutType("I");
			accountTranInfo.setTranAmt(autoAccountInfo.getAutoAmt());
			accountTranInfo.setAccountNumber(manageAccountInfo.getAccountNumber());
			accountTranInfo.setBankCode(manageAccountInfo.getBankCode());
			accountTranInfo.setOtherAccountNumber(autoAccountInfo.getAccountNumber());
			accountTranInfo.setOtherBankCode(autoAccountInfo.getBankCode());
			accountTranInfo.setToken(manageAccountInfo.getToken());
			accountTranInfoList.add(accountTranInfo);
			
		});
		
		
		/*
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		JsonObject parameters = new	JsonObject();
		parameters.addProperty("accountTranInfoList", accountTranInfoList.toString());
		HttpEntity<Object> entity = new HttpEntity<Object>(parameters.toString(), headers);
		*/
		String url = "http://localhost:18081/tran";
		RestTemplate restTemplate = new RestTemplate();
		Map<String, String> data = (Map<String, String>) restTemplate.postForObject(url,accountTranInfoList, Object.class);
		
		String apiResult = data.get("data");
		
		if(apiResult.equals("success")) {
			result = true;
			
			String msg = "";
			//자동이체 했다는 문자 보내기
			List<AutoTranInfoSMSVO> list = dao.selectAutoTranInfoSMS();
			for(int i = 0; i < list.size(); ++i) {
				if(i==0) {
					msg += "[ 자동이체 정보 ] \n"
						+ "* " + list.get(i).getBankName() + " " + list.get(i).getAccountNumber() + " : " + list.get(i).getAutoAmt() + "원\n";
				
				} else if(! list.get(i).getId().equals(list.get(i-1).getId()) && i != list.size() - 1 ) {
					AutoTranInfoSMS.autoTranInfoPhone(list.get(i-1).getPhone(), msg);
					msg = "";
					msg += "[ 자동이체 정보 ] \n";
					msg += "* " + list.get(i).getBankName() + " " + list.get(i).getAccountNumber() + " : " + list.get(i).getAutoAmt() + "원\n";
				} else if(! list.get(i).getId().equals(list.get(i-1).getId()) && i == list.size() - 1) {
					AutoTranInfoSMS.autoTranInfoPhone(list.get(i-1).getPhone(), msg);
					msg = "";
					msg += "[ 자동이체 정보 ] \n";
					msg += "* " + list.get(i).getBankName() + " " + list.get(i).getAccountNumber() + " : " + list.get(i).getAutoAmt() + "원\n";
					AutoTranInfoSMS.autoTranInfoPhone(list.get(i).getPhone(), msg);
				} else if(list.get(i).getId().equals(list.get(i-1).getId()) && i == list.size() - 1) {
					msg += "* " + list.get(i).getBankName() + " " + list.get(i).getAccountNumber() + " : " + list.get(i).getAutoAmt() + "원\n";
					AutoTranInfoSMS.autoTranInfoPhone(list.get(i).getPhone(), msg);
				}else if(list.get(i).getId().equals(list.get(i-1).getId()) && i != list.size() - 1) {
					msg += "* " + list.get(i).getBankName() + " " + list.get(i).getAccountNumber() + " : " + list.get(i).getAutoAmt() + "원\n";
				}
			}
			
		}
		
		return result;
	}
	
	//토큰 가져오기
	@Override
	public String getToken(String memberId) {
		return dao.selectToken(memberId);
	}
	
	//계좌이체
	@Override
	public boolean addTranInfo(AccountTransferInfoVO tranInfo) {
		boolean result = false;
		//회사 계좌 정보 가져오기
		ManageAccountInfoVO manageAccountInfo = dao.selectManageAccountInfo();
		
		//param
		List<AccountTransferInfoVO> accountTranInfoList = new ArrayList<>(); 
		
		AccountTransferInfoVO accountTranInfo = new AccountTransferInfoVO();
		//출금(유저 기준)
		accountTranInfo.setInoutType("O");
		accountTranInfo.setTranAmt(tranInfo.getTranAmt());
		accountTranInfo.setAccountNumber(tranInfo.getAccountNumber());
		accountTranInfo.setBankCode(tranInfo.getBankCode());
		accountTranInfo.setOtherAccountNumber(manageAccountInfo.getAccountNumber());
		accountTranInfo.setOtherBankCode(manageAccountInfo.getBankCode());
		accountTranInfo.setToken(tranInfo.getToken());
		accountTranInfoList.add(accountTranInfo);
		
		accountTranInfo = new AccountTransferInfoVO();
		//입금(회사 기준)
		accountTranInfo.setInoutType("I");
		accountTranInfo.setTranAmt(tranInfo.getTranAmt());
		accountTranInfo.setAccountNumber(manageAccountInfo.getAccountNumber());
		accountTranInfo.setBankCode(manageAccountInfo.getBankCode());
		accountTranInfo.setOtherAccountNumber(tranInfo.getAccountNumber());
		accountTranInfo.setOtherBankCode(tranInfo.getBankCode());
		accountTranInfo.setToken(manageAccountInfo.getToken());
		accountTranInfoList.add(accountTranInfo);
		
		String url = "http://localhost:18081/tran";
		RestTemplate restTemplate = new RestTemplate();
		Map<String, String> data = (Map<String, String>) restTemplate.postForObject(url,accountTranInfoList, Object.class);
		
		String apiResult = data.get("data");
		
		if(apiResult.equals("success")) {
			result = true;
		}
		
		return result;
	}
	
	
	//폰인증 결과 전송 받고 핀테크 이용번호 저장
	@Override
	public String checkAuthResult(String id, String memberId) {
		//id값 저장(이게 핀테크 이용번호)
		MemberVO member = new MemberVO();
		member.setFintechNo(id);
		member.setId(memberId);
		dao.updateFintechNo(member);
		
		//오픈뱅킹 동의
		System.out.println("오픈뱅킹 동의 memberId : " + memberId);
		dao.updateOpenbankingAgree(memberId);
		
		return id;
	}
	
	//회사토큰 발급
	@Override
	public String getOpenBankingToken() {
		
		//토큰 요청 보내기
		String url = "http://localhost:18081/newToken";
		RestTemplate restTemplate = new RestTemplate();
		Map<String, String> data = (Map<String, String>) restTemplate.postForObject(url,null, Object.class);
		
		String token = data.get("data");
		
		//db에 저장
		dao.insertOpenBankingToken(token);
		
		return token;
	}
}

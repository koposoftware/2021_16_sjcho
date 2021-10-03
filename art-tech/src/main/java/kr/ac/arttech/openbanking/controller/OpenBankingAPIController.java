package kr.ac.arttech.openbanking.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.arttech.openbanking.service.OpenBankingService;
import kr.ac.arttech.openbanking.vo.AccountInfoVO;
import kr.ac.arttech.openbanking.vo.AccountTransferInfoVO;
import kr.ac.arttech.openbanking.vo.AutoTranAccountVO;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/openbanking")
@RequiredArgsConstructor
public class OpenBankingAPIController {
	
	private final OpenBankingService service ;
	
	//거래내역 조회
	@RequestMapping("/tranInfo")
	public List<AccountTransferInfoVO> getTranInfo(AccountTransferInfoVO tranInfo,
			HttpServletRequest request){
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		List<AccountTransferInfoVO> tranInfoList = service.getTranInfoList(memberId, tranInfo);
		return tranInfoList;
	}
	
	//자동이체 설정 한 계좌 list 가져오기
	@RequestMapping("/autoAccountInfoList")
	public List<AutoTranAccountVO> getAutoAccount(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		List<AutoTranAccountVO> autoAccountList = service.getAutoAccountList(memberId);
		
		return autoAccountList;
	}
	
	//자동이체 설정
	@RequestMapping("/autoSetting")
	public String setAutoAccount(AutoTranAccountVO autoAccountInfo, 
			HttpServletRequest request) {
		System.out.println("컨트롤러 : " + autoAccountInfo);
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		boolean result = service.setAutoAccount(autoAccountInfo, memberId);
		
		if(result) {
			return "success";
		}
		
		return "fail";
	}
	
	
	@RequestMapping("/nonAutoAccountInfoList")
	public List<AccountInfoVO> getNonAutoAccountInfoList(AutoTranAccountVO autoAccountInfo, 
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		return service.getNonAutoAccountList(memberId);
	}
	
	
}

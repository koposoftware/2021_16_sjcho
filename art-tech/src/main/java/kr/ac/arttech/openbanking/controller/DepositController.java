package kr.ac.arttech.openbanking.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.arttech.openbanking.service.OpenBankingService;
import kr.ac.arttech.openbanking.vo.AccountInfoVO;
import kr.ac.arttech.openbanking.vo.AccountTransferInfoVO;
import kr.ac.arttech.openbanking.vo.AutoTranAccountVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/deposit")
@RequiredArgsConstructor
public class DepositController {
	
	private final OpenBankingService service;
	
	//예치금 조회
	@GetMapping("/myDeposit")
	public String myDeposit(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		if(! service.checkServiceAgree(memberId)) {
			return "openBanking/termsOfService";
		}
		
		//거래내역 가져오기 (예치금 - 전체, 오늘 날짜, 기본적 세팅)
		AccountTransferInfoVO tranInfo = new AccountTransferInfoVO();
		List<AccountTransferInfoVO> tranInfoList = null;
		
		tranInfo.setStartDate( LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) );
		tranInfo.setEndDate( LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) );
		tranInfo.setOrderBy("desc");
		tranInfo.setSelectInOutType("all");
		tranInfo.setSelectDepositYn("Y");
		
		tranInfoList = service.getTranInfoList(memberId, tranInfo);
		//예치금 총 금액 가져오기
		String totalDeposit = service.getDeposit(memberId);
		
		//이체 성공 시
		String resultTran = (String)session.getAttribute("resultTran");
		session.removeAttribute("resultTran");
		model.addAttribute("resultTran", resultTran) ;
		
		//데이터 보내기
		model.addAttribute("totalDeposit", totalDeposit);
		model.addAttribute("tranInfoList", tranInfoList);
		return "deposit/myDeposit";
	}
	
	//자동 예치금 이체설정한 계좌 안한 계좌 리스트 가져오기
	@GetMapping("/autoTranDeposit")
	public String autoTranAccount(HttpServletRequest request, Model model, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		if(! service.checkServiceAgree(memberId)) {
			return "openBanking/termsOfService";
		}
		
		//내 전체 계좌 리스트 가져오기
		List<AccountInfoVO> accountInfoList = service.getAccountInfoList(memberId);
		
		//자동이체 설정안한 계좌 list
		List<AccountInfoVO> nonAccountInfoList = service.getNonAutoAccountList(memberId);
		
		//자동이체 설정한 계좌 list
		List<AutoTranAccountVO> autoAccountInfoList = service.getAutoAccountList(memberId);
		
		
		model.addAttribute("accountInfoList", accountInfoList);
		model.addAttribute("autoAccountInfoList", autoAccountInfoList);
		model.addAttribute("nonAccountInfoList", nonAccountInfoList);
		
		return "deposit/autoTranDeposit";
	}
	
	//예치금 입금
	@GetMapping("/transferDeposit")
	public String transferDeposit(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("memberId");
		
		if(! service.checkServiceAgree(memberId)) {
			return "openBanking/termsOfService";
		}
		
		model.addAttribute("token", service.getToken(memberId));
		return "deposit/transferDeposit";
	}
	@PostMapping("/transferDeposit")
	public String transferDepositPost(AccountTransferInfoVO tranInfo, HttpSession session) {
		boolean result = service.addTranInfo(tranInfo);
		if(result) {
			session.setAttribute("resultTran", "success");
		}
		return "redirect:/deposit/myDeposit";
	}
	
	
	//자동이체 스케줄러
	//@Scheduled(cron="0/3 * * * * * ")
	@Scheduled(cron="0 0 13 * * * ")
	public void autoTranDeposit() {
		boolean result = service.startAutoTranDeposit();
		System.out.println("[자동이체]최종 result : " + result + "");
	}
}

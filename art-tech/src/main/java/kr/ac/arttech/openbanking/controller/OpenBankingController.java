package kr.ac.arttech.openbanking.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;

import kr.ac.arttech.member.vo.MemberVO;
import kr.ac.arttech.openbanking.service.OpenBankingService;
import kr.ac.arttech.openbanking.vo.AccountInfoVO;
import kr.ac.arttech.openbanking.vo.AuthenticationResponse;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/openBanking")
@RequiredArgsConstructor
public class OpenBankingController {
	
	private final OpenBankingService service;
	
	//계좌조회(리스트)
	@GetMapping("/myAccountList")
	public String myAccountListGet(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		boolean result = service.checkServiceAgree(memberId);
		
		String url = "openBanking/termsOfService";
		
		if(result) { //동의했으면
			url = "openBanking/myAccountList";
			List<AccountInfoVO> accountInfoList = service.getAccountInfoList(memberId);
			//List<AccountInfoVO> accountInfoList = service.getAccountInfoList(memberId);
			model.addAttribute("accountInfoList", accountInfoList);
		}
		return url;
		
	}
	
	//오픈뱅킹 동의한 후 계좌조회(리스트)로 이동
	@PostMapping("/myAccountList")
	public String myAccountListPost(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		//동의 선택
		boolean result = service.changeServiceAgreeState(memberId);
		
		if(! result) {
			return "redirect:/";
		}
		
		
		return "redirect:/openBanking/myAccountList";
	}
	
	
	//계좌조회(디테일)
	@GetMapping("/myAccountDetail")
	public String myAccountDetail(HttpServletRequest request, AccountInfoVO accountInfo, Model model) {
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		
		List<AccountInfoVO> result = service.getAccountInfo(memberId, accountInfo);
		model.addAttribute("accountInfo", result);
		return "openBanking/myAccountDetail";
	}
	
	//회사 토큰 가져오기
	//@Scheduled(cron="0 0 9 * * * ")
	public void openBankingToken() {
		service.getOpenBankingToken();
	}
	
}

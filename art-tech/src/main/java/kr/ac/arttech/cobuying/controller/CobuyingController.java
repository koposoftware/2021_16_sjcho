package kr.ac.arttech.cobuying.controller;

import java.awt.print.Pageable;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.arttech.cobuying.service.CobuyingService;
import kr.ac.arttech.cobuying.vo.PurchaseInfoVO;
import kr.ac.arttech.openbanking.service.OpenBankingService;
import kr.ac.arttech.util.PagingVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/co-buying")
@RequiredArgsConstructor
public class CobuyingController {
	private final OpenBankingService openBankingService;
	private final CobuyingService service;
	
	private Logger log = Logger.getLogger(CobuyingController.class);
	
	
	//@GetMapping("/goods")
	/*
	public String goodsList(Model model) {
		//model.addAttribute("artworkInfoList", service.getArtworkInfoList());
		return "co-buying/goods";
	}
	*/
	@GetMapping({"/goods", "/goods/{nowPage}"})
	public String goodsList(Model model, 
			@PathVariable Optional<String> nowPage,
			PagingVO vo) {
		int total = service.getArtworkCount();
		String nowPageRe = "";
		if(! nowPage.isPresent()) {
			nowPageRe = "1";
		}else {
			nowPageRe = nowPage.get();
		}
		
		vo = new PagingVO(total, Integer.parseInt(nowPageRe), 9);
		System.out.println("컨트롤러 vo : " + vo.toString());
		model.addAttribute("paging", vo);
		System.out.println("artworkInfoList : " + service.getArtworkInfoListPaging(vo));
		model.addAttribute("artworkInfoList", service.getArtworkInfoListPaging(vo));
		return "co-buying/goods";
	}
	
	@GetMapping("/goodsDetail/{id}")
	public String goodsDetail(@PathVariable("id") String id, 
			Model model) {
		
		log.info(id); //로그 찍기
		
		model.addAttribute("artworkInfo", service.getArtworkInfo(id).get("artworkInfo"));
		model.addAttribute("artworkInfoImg", service.getArtworkInfo(id).get("artworkInfoImg"));
		return "co-buying/goodsDetail";
	}
	
	@GetMapping("/purchase/{id}")
	public String purchaseGet(@PathVariable("id") String id, 
			Model model, HttpSession session) {
		//지갑 생성했는지 확인하기
		
		//예치금 정보 가져오기
		model.addAttribute("deposit", openBankingService.getDeposit((String)session.getAttribute("memberId")));
		
		//해당 작품 정보 가져오기
		model.addAttribute("artworkInfo", service.getArtworkInfo(id).get("artworkInfo"));
		return "co-buying/purchase";
	}
	
	@PostMapping("/purchase")
	public String purchasePost(PurchaseInfoVO purchaseInfo, 
			HttpSession session) {
		
		//member id set
		String memberId = (String)session.getAttribute("memberId");
		
		purchaseInfo.setMemberId(memberId);
		
		//price set
		int pieceNo = purchaseInfo.getPieceNo();
		purchaseInfo.setPlatformUsageFee(Integer.toString(pieceNo * 600));
		purchaseInfo.setVat(Integer.toString(pieceNo * 60));
		 
		//db 구매정보 insert & 조각 정보 update 
		boolean result = service.addPurchaseInfo(purchaseInfo);
		if(result) {
			session.setAttribute("resultPurchase", "success");
		}
		
		//blockchain insert
		
		return "redirect:/myPage/myHistory";
	}
	
	
	//소유자 현황
	@GetMapping("/ownership")
	public String ownership(Model model) {
		model.addAttribute("ownershipList", service.getOwnershipList());
		return "co-buying/ownership";
	}
	//소유자현황 디테일
	@GetMapping("/ownershipDetail/{id}")
	public String ownershipDetail(@PathVariable("id") String id, Model model) {
		
		//그림 정보
		model.addAttribute("artworkInfo", service.getArtworkInfo(id).get("artworkInfo"));
		//소유자 디테일
		model.addAttribute("totalOwnerList", service.getTotalOwnerList(id));
		//
		return "co-buying/ownershipDetail";
	}
	
	
	//매각 진행 현황
	@RequestMapping("/disposal")
	public String disposal(Model model) {
		System.out.println(service.getDisposalList());
		model.addAttribute("disposalList", service.getDisposalList());
		return "co-buying/disposal";
	}
	
	
	
	//상태 update
	//모집예정(0) -> 모집중(1) 날짜
	//현재 날짜 = 시작날짜이면 update
	
	//모집중(1) -> 모집완료(2)
	//현재 날짜 = 모집 종료 날짜 update
	//@Scheduled(cron="0 0 14 * * * ")
	//@Scheduled(cron="0/3 * * * * * ")
	public void updateState() {
		Map<String, Integer> map = service.modifyState();
		int resultStart = map.get("start");
		
		System.out.println("[아트테크 상태 update]총 " + map.get("total") + "개의 상태가 update");
	}
	
	
	
	
}

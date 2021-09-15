package kr.ac.arttech.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.arttech.member.service.MemberService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/myPage")
@RequiredArgsConstructor
public class MypageController {
	private final MemberService service;
	
	//구매내역 myHistory
	@GetMapping("/myHistory")
	public String myHistory(HttpSession session, Model model) {
		String resultPurchase = (String) session.getAttribute("resultPurchase");
		session.removeAttribute("resultPurchase");
		
		String memberId = (String) session.getAttribute("memberId");
		model.addAttribute("myHistoryListAll", service.getMyHistoryListAll(memberId));
		model.addAttribute("myHistoryDisposalInfoList", service.getMyHistoryDisposalInfoList(memberId));
		model.addAttribute("resultPurchase", resultPurchase);
		return "myPage/myHistory";
	}
	
	//myInfo
	@GetMapping("/myInfo")
	public String myInfo(HttpSession session, Model model) {
		String id = (String) session.getAttribute("memberId");
		
		model.addAttribute("member", service.getMemberInfo(id)) ;
		return "myPage/myInfo";
	}
	
	//myGallery
	@GetMapping("/myGallery")
	public String myGallery(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("option", "all");
		
		model.addAttribute("myGalleryList", service.getMyGalleryList(map));
		return "myPage/myGallery";
	}
	
	
}

package kr.ac.artTechManager.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ac.artTechManager.service.NoticeService;
import kr.ac.artTechManager.vo.NoticeVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/manage")
@RequiredArgsConstructor
public class NoticeController {
	private final NoticeService service;
	
	@GetMapping("/noticeList")
	public String list(HttpSession session, Model model) {
		
		String register = (String) session.getAttribute("register");
		session.removeAttribute("register");
		
		model.addAttribute("register", register);
		model.addAttribute("noticeList", service.getNoticeList()) ;
		return "manage/noticeList";
	}
	
	//디테일
	@GetMapping("/noticeDetail/{id}")
	public String detail(@PathVariable("id") String id, Model model) {
		model.addAttribute("notice", service.getNotice(id)) ;
		
		return "manage/noticeDetail";
	}
	
	@GetMapping("/noticeRegister")
	public String register() {
		
		return "manage/noticeRegister";
	}
	
	@PostMapping("/noticeRegister")
	public String registerPost(NoticeVO notice, HttpSession session) {
		boolean result = service.addNotice(notice);
		
		if(result) {
			session.setAttribute("register", "success");
		}
		
		return "redirect:/manage/noticeList";
	}
	
	
}

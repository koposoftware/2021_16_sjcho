package kr.ac.arttech.cobuying.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.arttech.cobuying.service.CobuyingService;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/co-buying")
@RequiredArgsConstructor
public class CobuyingAPIController {
	private final CobuyingService service;
	
	@PostMapping("/easyPassword")
	public String getEasyPassword(HttpSession session) {
		String id = (String) session.getAttribute("memberId");
		return service.getEasyPassword(id);
	}
	
	
}

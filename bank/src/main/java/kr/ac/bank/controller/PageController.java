package kr.ac.bank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
	
	@GetMapping("/OAuth")
	public String test() {
		System.out.println("여기 오나요?");
		return "phoneAuth";
	}
}

package kr.ac.bank.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.bank.service.BankService;
import lombok.RequiredArgsConstructor;


@RestController
@RequiredArgsConstructor
public class BankAPIController {
	
	private final BankService service;
	
	@PostMapping("/phoneAuth")
	public String phoneAuth(String phone) {
		return service.phoneAuth(phone);
	}
	
	@PostMapping("/phoneAuthCheck")
	public String phoneAuthCheck(String ranNo, String inputRanNo, String phone) {
		return service.phoneAuthCheck(ranNo, inputRanNo, phone);
	}
}

package kr.ac.arttech.artscan.controller;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.arttech.artscan.service.ArtscanService;
import kr.ac.arttech.util.CollaborativeFilteringUtil;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/artscan")
public class ArtscanController {
	private final ArtscanService service;
	
	@GetMapping("/")
	public String main() {
		
		return "artscan/index";
	}
	
	@GetMapping("/blocks")
	public String blocks() {
		
		return "artscan/blocks";
	}
	@GetMapping("/blockDetail/{hash}")
	public String blockDetail(@PathVariable("hash") String hash) {
		return "artscan/blockDetail";
	}
	
	
	@GetMapping("/txns")
	public String txns() {
		return "artscan/txns";
	}
	
	@GetMapping("/txnDetail/{transactionId}")
	public String txnDetail(@PathVariable("transactionId") String transactionId) {
		return "artscan/txnDetail";
	}
	
	@GetMapping("/address/{address}")
	public String address(@PathVariable("address") String address, Model model) {
		address = address.replace("!", "/");
		model.addAttribute("address", address);
		return "artscan/address";
	}
	
	@Scheduled(cron="0 0 9 * * * ")
	public void runCollaborativeFilteringModel() {
		CollaborativeFilteringUtil.runCollaborativeFilteringModel();
	}
}

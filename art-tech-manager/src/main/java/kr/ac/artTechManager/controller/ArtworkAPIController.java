package kr.ac.artTechManager.controller;


import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.artTechManager.service.ArtworkService;
import kr.ac.artTechManager.util.LogFileReader;
import kr.ac.artTechManager.vo.VoteVO;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/manage")
public class ArtworkAPIController {
	private final ArtworkService service;
	//매각투표 진행하기
	@PostMapping("/vote")
	public String vote(VoteVO vote) {
		return service.startVote(vote);
	}
	
	//작품 디테일 페이지에서 업무 버튼 클릭했을 때
	@PostMapping("/goodsDetailTast")
	public String goodsDetailTast(VoteVO vote) {
		return service.startGoodsDetailTast(vote);
	}
	
	//작품 당 클릭 수 그래프 (로그분석)
	@GetMapping("/goodsClickGraph")
	public Map<String, Object> goodsClickGraph() throws Exception {
		return service.getGoodsClickGraph();
	}
	
	//로그인 시간 그래프(로그분석)
	@GetMapping("/loginTimeGraph")
	public LinkedHashMap<String, Integer> loginTimeGraph() throws Exception {
		return service.getloginTime();
	}
	
}

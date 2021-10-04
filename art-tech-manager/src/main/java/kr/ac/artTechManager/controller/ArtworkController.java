package kr.ac.artTechManager.controller;


import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.ac.artTechManager.service.ArtworkService;
import kr.ac.artTechManager.service.WriterInfoService;
import kr.ac.artTechManager.vo.ArtworkInfoVO;
import kr.ac.artTechManager.vo.WriterInfoVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/manage")
@RequiredArgsConstructor
public class ArtworkController {
	private final ArtworkService service;
	private final WriterInfoService writerSerivce;
	
	@GetMapping("/goodsRegister")
	public String addArtworkInfoGet(Model model, HttpSession session) {
		List<WriterInfoVO> writerInfoList = writerSerivce.getWriterInfoList();
		model.addAttribute("writerInfoList", writerInfoList);
		
		return "manage/goodsRegister";
	}
	
	//작품등록
	@PostMapping("/goodsRegister")
	public String addArtworkInfoPost(ArtworkInfoVO artworkInfo, HttpSession session,
			@RequestParam("file")List<MultipartFile> multipartFile) throws Exception{
		boolean result = service.addArtworkInfo(artworkInfo, multipartFile);
		if(result) {
			session.setAttribute("register", "success");
			
		}
		
		return "redirect:/manage/goods"; 
	}
	
	
	//작품리스트
	@GetMapping("/goods")
	public String goodsList(Model model, HttpSession session) {
		String register = (String) session.getAttribute("register");
		session.removeAttribute("register");
		
		List<ArtworkInfoVO> artworkInfoList = service.getArtworkInfoList();
		model.addAttribute("artworkInfoList", artworkInfoList);
		model.addAttribute("register", register);
		
		return "manage/goods";
	}
	
	//작품 디테일
	@GetMapping("/goodsDetail/{artworkInfoId}")
	public String goodsDetail(@PathVariable String artworkInfoId, Model model) {
		ArtworkInfoVO artworkInfo = (ArtworkInfoVO) service.getArtworkInfo(artworkInfoId).get("artworkInfo");
		
		if(! artworkInfo.getState().equals("0") || ! artworkInfo.getState().equals("1")) {
			//투표 정보 가져오기
			model.addAttribute("voteInfo", service.getVoteInfo(artworkInfoId));
			if(! artworkInfo.getState().equals("3")) { //투표 종료
				BufferedReader br = null;
				int agree = 0;
				int disagree = 0;
				try {
					String path = "C:\\art-tech\\votefile\\" + artworkInfoId + ".csv";
					br = Files.newBufferedReader(Paths.get(path));
					//Charset.forName("UTF-8");
		            String line = "";
		            
		            while((line = br.readLine()) != null){
		                if(line.split(",")[2].equals("동의")) {
		                	++ agree;
		                }else if(line.split(",")[2].equals("반대")) {
		                	++ disagree;
		                }
		            }
		            model.addAttribute("agree", agree);
		            model.addAttribute("disagree", disagree);
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if(br != null) {
							br.close();
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
					
				}
			}
		}
		model.addAttribute("artworkInfo", artworkInfo);
		return "manage/goodsDetail";
	}
	
	@GetMapping("/statistics")
	public String statistics(Model model) {
		
		//로그인 많이 한 회원 리스트
		try {
			model.addAttribute("loginTopMemberList", service.geLoginTopMemberList());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("genderNo", service.getGenderNo());
		model.addAttribute("cobuyingParticipation", service.getCobuyingParticipation());
		return "manage/statistics";
	}
	
	//투표중(3) -> 투표종료(4)
	//현재날짜 = 투표종료 날짜
	@Scheduled(cron="0 0 24 * * * ")
	public void updateStateVote() {
		int result = service.modifyStateVote();
		System.out.println("총 " + result + "개의 상태가 update");
	}
	
	
}

package kr.ac.arttech;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.arttech.cobuying.service.CobuyingService;
import kr.ac.arttech.cobuying.vo.ArtworkInfoVO;
import kr.ac.arttech.notice.service.NoticeService;
import kr.ac.arttech.util.ArttechCrawling;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class IndexController {
	
	private final CobuyingService cobuyingService;
	private final NoticeService noticeService;
	
	@GetMapping("/")
	public ModelAndView main(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		//회원가입 성공 또는 실패 확인
		String resultJoin = (String) session.getAttribute("resultJoin");
		if(resultJoin != null || resultJoin == "") {
			session.removeAttribute("resultJoin");
			mav.addObject("resultJoin", resultJoin); //회원가입 성공 시 success가 index로 간다.
		}
		
		//뉴스기사 크롤링
		mav.addObject("newsList", ArttechCrawling.getArttechNews()) ;
		
		//공동구매 
		mav.addObject("artworkList", cobuyingService.getArtworkInfoList());
		
		//공지사항
		mav.addObject("noticeList", noticeService.getNoticeList());
		
		//협업필터링(작품 추천)
		
		if(memberId != "" || memberId != null) {
			List<ArtworkInfoVO> recommendArtworkInfoList = cobuyingService.getRecommendArtworkInfoList(memberId);
			if(recommendArtworkInfoList != null) {
				mav.addObject("recommendArtworkInfoList", cobuyingService.getRecommendArtworkInfoList(memberId));
			}
		}
		
		mav.setViewName("index");
		return mav;
	}
}

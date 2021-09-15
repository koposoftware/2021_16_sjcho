package kr.ac.arttech.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.arttech.cobuying.controller.CobuyingController;
import kr.ac.arttech.member.service.MemberService;
import kr.ac.arttech.member.vo.MemberVO;
import kr.ac.arttech.util.SecurityUtil;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
	private final MemberService service;
	
	private Logger log = Logger.getLogger(CobuyingController.class);
	
	//회원가입
	@GetMapping("/signup")
	public String joinGet() {
		
		return "member/signup";
	}
	
	
	@PostMapping("/signup")
	public String joinPost(MemberVO member, HttpSession session) {
		
		//insert
		boolean resultJoin = service.addMember(member);
		
		if(resultJoin) {
			//세션 저장하기 하기
			session.setAttribute("resultJoin", "success");
		}
		
		return "redirect:/";
	}
	
	//로그인
	@GetMapping("/signin")
	public String singinGet(HttpSession session, Model model) {

		
		String resultSignin = (String)session.getAttribute("resultSignin");
		session.removeAttribute("resultSignin");
		model.addAttribute("resultSignin", resultSignin);
		
		return "member/signin";
	}
	
	
	@PostMapping("/signin")
	public String singinPost(MemberVO member, HttpSession session) {
		
		
		
		//password 암호화
		String password = SecurityUtil.encryptSHA256(member.getPassword());
		member.setPassword(password);
		
		int result = service.checkSignin(member);
		if(result == 0) {
			session.setAttribute("resultSignin", "0");
			
	    }else if(result == 1) {
	    	session.setAttribute("resultSignin", "1");
	    	
		}else if(result == 2) { //로그인 성공
			
			//세션 저장하기 하기
			//id(pk) 가져오기
			String memberId = service.getMemberId(member.getUserId());
			session.setAttribute("memberId", memberId);
			
			log.info("로그인:"+memberId); //로그인 log 찍기
			
			//인터셉터 확인
			String dest = (String) session.getAttribute("dest");
			if(dest != null) {
				System.out.println("dest 확인 : " + dest);
				session.removeAttribute(dest);
				return "redirect:" + dest;
			}
			
			return "redirect:/" ;
		}
		
		return "redirect:/member/signin";
	}
	
	//로그아웃
	@GetMapping("/signout")
	public String signout(HttpSession session) {
		session.removeAttribute("memberId");
		return "redirect:/";
	}
	
	
}

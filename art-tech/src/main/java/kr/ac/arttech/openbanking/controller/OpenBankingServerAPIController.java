package kr.ac.arttech.openbanking.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.maven.artifact.repository.Authentication;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.arttech.openbanking.service.OpenBankingService;
import kr.ac.arttech.openbanking.vo.AuthenticationResponse;
import kr.ac.arttech.openbanking.vo.Response;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class OpenBankingServerAPIController {
	private final OpenBankingService service ;
	
	//폰인증 결과 전송받기
	@PostMapping("/authResult")
	public Response<?> authResult(@RequestBody String id,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		
		System.out.println("컨트롤러 세션 memberId : " + memberId);
		service.checkAuthResult(id, memberId);
		
		return Response.builder()
                .code(1)
                .msg("success")
                .data("success")
                .build();
	}
}

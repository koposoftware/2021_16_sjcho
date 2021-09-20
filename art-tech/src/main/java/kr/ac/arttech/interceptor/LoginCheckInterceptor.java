package kr.ac.arttech.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//로그인 유무 체크
		HttpSession session = request.getSession();
		
		if(session != null) {
			String memberId = (String) session.getAttribute("memberId");
			if(memberId == null) {
				String uri = request.getRequestURI();
				StringBuffer url = request.getRequestURL();
				
				uri = uri.substring(request.getContextPath().length());
				
				session.setAttribute("dest", uri);
				response.sendRedirect(request.getContextPath() + "/member/signin");
				return false;
			}
		}
		
		return true;
	}
}

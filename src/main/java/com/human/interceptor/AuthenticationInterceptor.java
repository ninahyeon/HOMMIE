package com.human.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 인터셉트 기능을 정의한 객체 (핸들러 이벤트 객체를 상속 받아야 한다)
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 컨트롤러 진입 전 인터셉트
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("logID"); // 세션에서 값 가져오기
		if (userID == null) { // 로그인 안 했네?
			response.sendRedirect(request.getContextPath() + "/login");
			return false; // 바로 위에 지정한 경로로 우회하여라.
		}
		return super.preHandle(request, response, handler); // 가고싶은 컨트롤러로 가라
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// 컨트롤러 진입 후 인터셉트
		super.postHandle(request, response, handler, modelAndView);
	}

}

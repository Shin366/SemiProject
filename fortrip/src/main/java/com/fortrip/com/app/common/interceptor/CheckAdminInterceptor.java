package com.fortrip.com.app.common.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CheckAdminInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String adminYn = (String)request.getSession().getAttribute("adminYn");
		System.out.println("=== 인터셉터 adminYN 체크: " + adminYn);
		if(adminYn == null || adminYn.equals("N")) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write("<script>alert('권한이 없습니다.'); location.href='/';</script>");
			
			return false;
		}
		return true;
	}
}

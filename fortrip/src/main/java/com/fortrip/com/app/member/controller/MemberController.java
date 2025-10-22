package com.fortrip.com.app.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fortrip.com.app.member.dto.JoinRequest;
import com.fortrip.com.app.member.dto.LoginRequest;
import com.fortrip.com.domain.member.model.service.MemberService;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberController {
	
	private final BCryptPasswordEncoder bcrypt;
	
	@Autowired
	private MemberService mService;
	
	@RequestMapping(value = "/member/login", method = RequestMethod.GET)
	public String showLoginPage() {
		return "member/login";
	}
	
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String checkLogin(
			@ModelAttribute LoginRequest member
			, HttpSession session
			, Model model) {
		try {
			System.out.println(member.getMemberPw());
			System.out.println(bcrypt.encode(member.getMemberPw()));
			Member result = mService.seleteOneByLogin(member);
			if(result != null && bcrypt.matches(member.getMemberPw(), result.getMemberPw())) {
				session.setAttribute("memberId", result.getMemberId());
				session.setAttribute("memberName", result.getMemberName());
				return "redirect:/index.jsp";
			}else {
				model.addAttribute("errorMsg", "데이터가 없습니다.");
				return "common/error"; //에러 페이지 만들면 url 넣기
			}
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";	//에러 페이지 만들면 url 넣기
		}
	}
	
	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public String processLogout(HttpSession session) {
		if(session != null) {
			session.invalidate();
		}
		return "redirect:index.jsp";
	}
	
	@RequestMapping(value = "/member/signup", method = RequestMethod.GET)
	public String showSignupView() {
		return "member/signup";
	}
	
	@RequestMapping(value = "/member/signup", method = RequestMethod.POST)
	public String signupMember(
			@ModelAttribute JoinRequest member
			, Model model) {
		try {
			member.setMemberPw(bcrypt.encode(member.getMemberPw()));
			int result = mService.insertMember(member);
			return "redirect:/member.login";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";	//에러 페이지 만들면 url 넣기
		}
	}
	
	
	//
	
}

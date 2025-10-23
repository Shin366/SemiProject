package com.fortrip.com.app.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
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
@RequestMapping("member")
public class MemberController {
	
	private final BCryptPasswordEncoder bcrypt;
	private final MemberService mService;
	
	@GetMapping("login")
	public String showLoginPage() {
		return "member/login";
	}
	
	@PostMapping("login")
	public String checkLogin(
			@ModelAttribute LoginRequest member
			, HttpSession session
			, Model model) {
		try {
			Member result = mService.seleteOneByLogin(member);
			System.out.println(result);
			System.out.println(member);
			if(result != null && bcrypt.matches(member.getMemberPw(), result.getMemberPw())) {
				session.setAttribute("memberId", result.getMemberId());
				session.setAttribute("memberName", result.getMemberName());
				return "index";
			}else {
				model.addAttribute("errorMsg", "데이터가 없습니다.");
				return "common/error"; //에러 페이지 만들면 url 넣기
			}
		} catch (Exception e) {
			model.addAttribute("ercmdrorMsg", e.getMessage());
			return "common/error";	//에러 페이지 만들면 url 넣기
		}
	}
	
	@GetMapping("logout")
	public String processLogout(HttpSession session) {
		if(session != null) {
			session.invalidate();
		}
		return "redirect:index.jsp";
	}
	
	@GetMapping("signup")
	public String showSignupView() {
		return "member/signup";
	}
	
	@PostMapping("signup")
	public String signupMember(
			@ModelAttribute JoinRequest member
			, Model model) {
		try {
			member.setMemberPw(bcrypt.encode(member.getMemberPw()));
			int result = mService.insertMember(member);
			return "redirect:/member/login";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";	//에러 페이지 만들면 url 넣기
		}
	}
	
	@GetMapping("delete")
	public String showDeletePage() {
		return "member/detele";
	}
	
	@PostMapping("delete")
	public String memberDelete(
			@ModelAttribute LoginRequest member
			,HttpSession session
			, Model model) {
		try {
			String memberId = (String)session.getAttribute("memberId");
			if(memberId == null) {
				model.addAttribute("errorMsg", "로그인 정보가 없습니다.");
				return "common/error";
			}
			
			Member dbMember = mService.selectOneById(memberId);
			
				if(bcrypt.matches(member.getMemberPw(), dbMember.getMemberPw())) {
					int result = mService.deleteMember(memberId);				
				
				if(result > 0) {
					session.invalidate();
					return "redirect:/member/logout";
				}else {
					model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
					return "common/error";
				}
			}else {
				model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
				return "common/error";
			}
			
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
}

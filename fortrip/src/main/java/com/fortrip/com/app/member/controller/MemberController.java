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
	
	
	@GetMapping("pwSearch")	// 아이디, 이메일이 같으면 비밀번호 보여주기 > 근데 보호를 해놔서 어떻게 보여줄 수 있는지 여쭤봐야함
	public String showpwSearchPage() {
		return "member/pwSearch";
	}
	
	@PostMapping("pwSearch")
	public String pwSearch() {
		return "";
	}
	
	@GetMapping("idSearch")	// 이름, 이메일이 같으면 아이디 보여주기
	public String showidSearchPage() {
		return "member/idSearch";
	}
	
	@PostMapping("idSearch")
	public String idSearch() {
		return "";
	}
	
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
			System.out.println(member.getMemberPw());
			System.out.println(bcrypt.encode(member.getMemberPw()));
			Member result = mService.selectOneByLogin(member);
			if(result != null && bcrypt.matches(member.getMemberPw(), result.getMemberPw())) {
				session.setAttribute("memberId", result.getMemberId());
				session.setAttribute("memberName", result.getMemberName());
				return "redirect:/";
			}else {
				model.addAttribute("errorMsg", "데이터가 없습니다.");
				return "common/error"; //에러 페이지 만들면 url 넣기
			}
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";	//에러 페이지 만들면 url 넣기
		}
	}
	
	@GetMapping("logout")
	public String processLogout(HttpSession session) {
		if(session != null) {
			session.invalidate();
		}
		return "redirect:/";
	}
	
	@GetMapping("use")
	public String showSignupView() {
		return "member/use";
		
	}
	
	@PostMapping("use")
	public String use() {
		return "";
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
	
	
	@GetMapping("profile")
	public String showProfilePage() {
		return "member/profile";
	}
	
	
	@PostMapping("profile")
	public String profileUpdate() {
		return "/member/profile";
	}
	
	
	@GetMapping("delete")
	public String showDeletePage() {
		return "member/delete";
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

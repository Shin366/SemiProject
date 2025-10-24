package com.fortrip.com.app.member.controller;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.fortrip.com.app.common.util.TempPwUtil;
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
	public String pwSearch(
			@RequestParam("memberId") String memberId
			, @RequestParam("email") String email
			, Model model
			) {
		try {
			Member member = mService.selectOneById(memberId);
			if(member == null || !member.getEmail().equals(email)) {
				model.addAttribute("errorMsg", "일치하는 회원 정보가 없습니다.");
				return "common/error";
			}
			// 임시 비번 만들어주는 코드
			String tempPw = TempPwUtil.generateSecureTempPassword(10);
			// 임시 비번 암호화해서 DB 저장함
			String encodedPw = bcrypt.encode(tempPw);
			int result = mService.updateMemberPw(memberId, encodedPw);
			
			if(result > 0) {
				model.addAttribute("tempPw", tempPw);
				return "member/pwSearchResult";				
			}
			return "common/pwSearch";
			
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
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
			// 로그인 정보로 member 객체 조회
			Member loginMember = mService.selectOneByLogin(member);
			/* 주애 코드
				System.out.println(member.getMemberPw());
				System.out.println(bcrypt.encode(member.getMemberPw()));
				Member result = mService.selectOneByLogin(member);
				if(result != null && bcrypt.matches(member.getMemberPw(), result.getMemberPw())) {
					session.setAttribute("memberId", result.getMemberId());
					session.setAttribute("memberName", result.getMemberName());
					// 우리는 회원 닉네임이 있는데 회원이름을 받아오는 이유?
					// 멤버 객체를 저장해서 사용하면 훨씬 용이
					return "redirect:/";
				}else {
					model.addAttribute("errorMsg", "데이터가 없습니다.");
					return "common/error"; //에러 페이지 만들면 url 넣기
				}
			 */
			if (loginMember != null && bcrypt.matches(member.getMemberPw(), loginMember.getMemberPw())) {
				session.setAttribute("loginMember", loginMember);
				
				return "redirect:/";
			}else {
				model.addAttribute("errorMsg", "데이터가 없습니다.");
				return "member/login";
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
	
	@GetMapping("use1")
	public String showUse1Page() {
		return "member/use1";
	}
	
	@GetMapping("use2")
	public String showUse2Page() {
		return "member/use2";
	}
	
	@GetMapping("use3")
	public String showUse3Page() {
		return "member/use3";
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
	
	@GetMapping("profile")
	public String showProfilePage() {
		return "member/profile";
	}
	
	
	@PostMapping("profile")
	public String profileUpdate() {
		return "/member/profile";
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

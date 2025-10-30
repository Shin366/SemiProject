package com.fortrip.com.app.member.controller;

import java.util.List;

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
import com.fortrip.com.app.member.dto.ModifyRequest;
import com.fortrip.com.app.member.dto.MyBoard;
import com.fortrip.com.app.member.dto.pwUpdateRequest;
import com.fortrip.com.domain.member.model.service.MemberService;
import com.fortrip.com.domain.member.model.service.MyPageService;
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
			int result = mService.updateTempMemberPw(memberId, encodedPw);
			
			if(result > 0) {
				model.addAttribute("tempPw", tempPw);
				return "member/pwSearchResult";				
			}
			return "member/pwSearch";
			
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
	public String idSearch(
			Member member
			, Model model
			) {
		try {
			Member findMember = mService.findMemberId(member);
			if(findMember != null) {
				model.addAttribute("memberId", findMember.getMemberId());
				return "member/idSearchResult";
			}
			return "member/idSearch";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	@GetMapping("login")
	public String showLoginPage() {
		return "member/login";
	}
	
	@PostMapping("login")
	public String checkLogin(
			@ModelAttribute LoginRequest member
			, HttpSession session
			, Model model
			, @RequestParam(value = "beforeURL", required=false)String beforeURL) {
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
			if (loginMember == null || "N".equals(loginMember.getStatusYsn())) {
			    model.addAttribute("msg", "회원 정보가 없습니다.");
			    model.addAttribute("url", "/member/login");
			    return "common/alert";
			}
			
			if (bcrypt.matches(member.getMemberPw(), loginMember.getMemberPw())) {
			    session.setAttribute("loginMember", loginMember);
			    session.setAttribute("adminYn", loginMember.getAdminYn());
			    
			    // 디버깅용 코드
			    String adminYn = (String) session.getAttribute("adminYn");
				System.out.println("로그인 멤버 관리자 여부: " + adminYn);
				if(loginMember.getAdminYn().equals("Y")) {
					return "admin/admin";
				}else {
					
					return "redirect:" + (beforeURL != null ? beforeURL : "/");
				}
				
			}else {
				model.addAttribute("errorMsg", "데이터가 없습니다.");
				return "member/login";
			}
		} catch (Exception e) {
			e.printStackTrace(); //에러 확인용
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
		return "member/signup";
	}
	
	// 회원가입 - for trip 이용약관 이용약관 연결용
	@GetMapping("use1")
	public String showUse1Page() {
		return "member/use1";
	}
	
	// 회원가입 - 개인정보 수집 및 이용 이용약관 연결용
	@GetMapping("use2")
	public String showUse2Page() {
		return "member/use2";
	}
	
	// 회원가입 - 개인정보 제3자 제공 이용약관 연결용
	@GetMapping("use3")
	public String showUse3Page() {
		return "member/use3";
	}
	
	@GetMapping("signup")
	public String showSignupPage() {
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
	
	
	@GetMapping("profile")
	public String showProfilePage(HttpSession session, Model model) {
	   try {
	        // 세션에서 로그인 회원 정보 가져오기
	        Member loginMember = (Member) session.getAttribute("loginMember");
	        
	        if(loginMember == null) {
	            model.addAttribute("errorMsg", "로그인이 필요합니다.");
	            return "common/error";
	        }
	        
	        // DB에서 최신 회원 정보 조회
	        String memberId = loginMember.getMemberId();
	        Member member = mService.selectOneById(memberId);
	        
	        if(member == null) {
	            model.addAttribute("errorMsg", "회원 정보를 찾을 수 없습니다.");
	            return "common/error";
	        }
	        
	        //  Model에 member 객체 담기
	        model.addAttribute("member", member);
	        
	        return "member/profile";
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
	}
	
	
	@PostMapping("profile")
	public String profileUpdate() {
		return "/member/profile";
	}
	
	
	
	@GetMapping("list")
	public String showListPage() {
		return "member/list";
	}
	
	@PostMapping("list")
	public String listPage() {
		return "member/list";
	}
	
	
	@GetMapping("update")
	public String showUpdate() {
		return "member/update";
	}
	
	@PostMapping("update")
	public String modifyProfile(@ModelAttribute ModifyRequest member
			,HttpSession session, Model model) {
		try {
			Member loginMember = (Member)session.getAttribute("loginMember");
			System.out.println(loginMember);
			if (loginMember == null) {
			    model.addAttribute("errorMsg", "로그인 정보가 없습니다.");
			    return "common/error";
			}
			
			member.setMemberId(loginMember.getMemberId());
			int result = mService.updateMember(member);
			
			if(result > 0) {
				return "/member/updateResult";
			}else {
				model.addAttribute("errorMsg", "SERVICE_FAILED");
				return "common/error";
			}
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";			
		}
	}
	
	@GetMapping("pwUpdate")
	public String showPwUpdate() {
		return "member/pwUpdate";
	}
	
	@PostMapping("pwUpdate")		//기존에 있는 비밀번호랑 작성한 비번이 같고 새로운 비번 두번을 일치하게 적으면 바뀌는 형식
	public String pwUpdate(@ModelAttribute pwUpdateRequest request
			, HttpSession session, Model model) {
		try {
			Member loginMember = (Member)session.getAttribute("loginMember");
			
			if(loginMember == null) {
				model.addAttribute("errorMsg", "로그인 정보가 없습니다");
				return "common/error";
			}
			String memberId = loginMember.getMemberId();
			Member dbMember = mService.selectOneById(memberId);
			
			if(!bcrypt.matches(request.getCurrentPw(), dbMember.getMemberPw())) {
				model.addAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
				return "common/error";
			}
			
			if(!request.getNewPw().equals(request.getConfirmPw())) {
				model.addAttribute("errorMsg", "새 비밀번호가 일치하지 않습니다.");
				return "common/error";
			}
			String encodeNewPw = bcrypt.encode(request.getNewPw());
			int result = mService.updateTempMemberPw(memberId, encodeNewPw);
			
			if(result > 0) {
				session.invalidate();
				return "member/pwUpdateResult";
			}else {
				model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다.");
				return "common/error";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
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
			Member loginMember = (Member) session.getAttribute("loginMember");
			if(loginMember == null) {
				System.out.println(loginMember);
				model.addAttribute("errorMsg", "로그인 정보가 없습니다.");
				return "common/error";
			}
			String memberId = loginMember.getMemberId();
			System.out.println("탈퇴 요청 회원 ID: " + memberId);
			Member dbMember = mService.selectOneById(memberId);
			
				if(dbMember == null) {
		            model.addAttribute("errorMsg", "회원 정보를 찾을 수 없습니다.");
		            return "common/error";
		        }
			
				if(bcrypt.matches(member.getMemberPw(), dbMember.getMemberPw())) {
					int result = mService.deleteMember(memberId);				
				if(result > 0) {
					session.invalidate();
					return "member/deleteResult";
				}else {
					model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
					return "common/error";
				}
			}else {
				model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
				return "member/delete";
			}
			
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	@GetMapping("/admin/user/admin")
	public String showAdminMain() {
		return "/admin/admin";	//이 url이 맞는지 모르겠음 //test
	}
	
}

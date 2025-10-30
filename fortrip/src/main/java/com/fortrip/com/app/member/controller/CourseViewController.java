package com.fortrip.com.app.member.controller;

import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fortrip.com.domain.member.model.service.CourseViewHistoryService;
import com.fortrip.com.domain.member.model.service.MemberService;
import com.fortrip.com.domain.member.model.vo.CourseViewHistory;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CourseViewController {
	
	private final CourseViewHistoryService hService;
	
	// 코스 상세 페이지 조회
		@GetMapping("trip/coursedetail/{courseId}")
		public String viewCourseDetail(@PathVariable Long courseId, HttpSession session) {
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(loginMember != null) {
				hService.recordCourseView(loginMember.getMemberNo(), courseId, "U");
			}
			return "trip/coursedetail";
		}
		
		// 최근 본 코스 목록
		@GetMapping("member/recent")
		public String showRecentCourses(
		        @RequestParam(defaultValue = "1") int page,
		        HttpSession session,
		        Model model) {
		    
			try {
				Member loginMember = (Member) session.getAttribute("loginMember");
			    
			    if (loginMember == null) {
			        model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
			        return "redirect:/member/login";
			    }
			    
			    long memberNo = loginMember.getMemberNo();
			    int pageSize = 20; // 한 페이지당 20개씩
			    
			    List<CourseViewHistory> list = hService.getRecentCourses(memberNo, page, pageSize);
			    
			    System.out.println("조회된 최근 본 코스 수: " + (list != null ? list.size() : 0));
			    
			    model.addAttribute("recentList", list);
			    model.addAttribute("page", page);
			    model.addAttribute("member", loginMember);
			    
			    return "member/recent";
			    
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("errorMsg", e.getMessage());
				return "common/error";
			}
		}
	}

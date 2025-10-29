package com.fortrip.com.app.member.controller;

import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fortrip.com.domain.member.model.service.CourseViewHistoryService;
import com.fortrip.com.domain.member.model.service.MemberService;
import com.fortrip.com.domain.member.model.vo.CourseViewHistory;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("member/course")
public class CourseViewController {
	
	private final CourseViewHistoryService hService;
	
	@GetMapping("login")
	public String viewCourseDetail(@PathVariable long courseId, HttpSession session) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember != null) {
			hService.recordCourseView(loginMember.getMemberNo(),courseId, "U");
		}
		return "course/detail";
		
	}
	
	@GetMapping("list")
	public String showRecentCourses(HttpSession session, Model model) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember == null) {
			return "redirect:/member/login";
		}
		List<CourseViewHistory> list = hService.getRecentCourses(loginMember.getMemberNo());
		model.addAttribute("recentList", list);
		return "";	
	}
}

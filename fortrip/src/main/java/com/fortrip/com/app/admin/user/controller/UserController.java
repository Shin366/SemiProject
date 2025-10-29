package com.fortrip.com.app.admin.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fortrip.com.app.admin.user.dto.UserAddDTO;
import com.fortrip.com.app.admin.user.dto.UserModifyDTO;
import com.fortrip.com.domain.admin.user.model.service.UserService;
import com.fortrip.com.domain.admin.user.model.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/user")
@RequiredArgsConstructor
public class UserController {
	
	private final UserService uService;
	
	// 유저 추가 페이지 이동
	@GetMapping("/insert")
	public String userPage() {
		return "admin/user/userInsert";
	}
	
	// 유저 추가 
	@PostMapping("/insert")
	public String userAdd(@ModelAttribute UserAddDTO user, Model model) {
		try {
			int result = uService.userAdd(user); 
			
			if (result > 0) {
				model.addAttribute("success", "회원 추가 성공");
			} else {
				model.addAttribute("error", "회원 추가 실패");
			}
			return "admin/user/userInsert";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "admin/user/userInsert";
		}
	}
	
	// 유저 수정 페이지
	@GetMapping("/modify")
	public String userModifyPage(Model model, @RequestParam("memberNo") int memberNo) {
		System.out.println(memberNo);
		UserVO member = uService.userModifyInfo(memberNo);
		model.addAttribute("memberInfo", member);
		return "admin/user/usermodify";
	}
	
	// 유저 수정 페이지 저장
	@PostMapping("/modify")
	public String userModifyPost(@ModelAttribute UserModifyDTO user, Model model) {
		try {
			int result = uService.userModifyPost(user);
			
			if (result > 0) {
				model.addAttribute("success", "회원 수정 완료");
				return "admin/user/usermodify";
			} else {
				model.addAttribute("error", "회원 수정 실패");
				return "admin/user/usermodify";
			}
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "수정 실패");
			return "admin/admin";
		}
	}
}

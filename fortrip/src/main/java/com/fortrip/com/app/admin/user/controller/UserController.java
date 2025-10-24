package com.fortrip.com.app.admin.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fortrip.com.app.admin.user.dto.UserAddDTO;
import com.fortrip.com.domain.admin.user.model.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/user")
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
			return "user/userInsert";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "user/userInsert";
		}
	}
}

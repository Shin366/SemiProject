package com.fortrip.com.app.admin.home.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.fortrip.com.app.admin.home.dto.GetMemberDTO;
import com.fortrip.com.domain.admin.home.model.service.MemberInfoService;
import com.fortrip.com.domain.admin.home.model.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {
	private final MemberInfoService mService;
	
	@GetMapping("/")
	public String homePage(Model model) {
		/* 전체 회원 수 */
		int getMemberCount = mService.getMemberCount();
		/* 활성 회원 수 */
		int getMemberActive = mService.getMemberActive();
		/* 활동 정지 회원 수 */
		int getMemberStop = mService.getMemberStop();
		/* 회원 전체 가져오기 */
		List<MemberVO> mList = mService.getAllMemeber();
		
		model.addAttribute("mList", mList);
		model.addAttribute("getMemberCount", getMemberCount);
		model.addAttribute("getMemberActiveCount", getMemberActive);
		model.addAttribute("getMemberStopCount", getMemberStop);
		return "index";
	}
}

package com.fortrip.com.app.member.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fortrip.com.domain.board.bookmark.model.vo.BookmarkVO;
import com.fortrip.com.domain.member.model.service.MemberBookmarkService;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberBookmarkController {
	
	private final MemberBookmarkService bService;
	
	 @GetMapping("/member/bookmark")
	    public String showBookmarkList(Model model, HttpSession session) {
	        Member loginMember = (Member) session.getAttribute("loginMember");

	        if (loginMember == null) {
	            return "redirect:/member/login";
	        }

	        int memberNo = loginMember.getMemberNo();
	        List<BookmarkVO> bookmarkList = bService.selectBookmarksByMember(memberNo);

	        model.addAttribute("bookmarkList", bookmarkList);
	        model.addAttribute("bookmarkCount", bookmarkList.size());

	        return "member/bookmark"; // 네가 만든 bookmark.jsp 경로
	    }
}

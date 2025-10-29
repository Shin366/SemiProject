package com.fortrip.com.app.board.bookmark.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fortrip.com.domain.board.bookmark.model.service.BookmarkService;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board/bookmark")
public class BookmarkController {

    @Autowired
    private BookmarkService bookmarkService;

    @PostMapping("/toggle")
    @ResponseBody
    public Map<String, Object> toggleBookmark(
            @RequestParam String targetType,
            @RequestParam int targetNo,
            HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        Map<String, Object> result = new HashMap<>();

        if (loginMember == null) {
            result.put("status", "fail");
            result.put("message", "로그인 후 이용해주세요.");
            return result;
        }

        boolean isBookmarked = bookmarkService.toggleBookmark(loginMember.getMemberNo(), targetType, targetNo);
        
        int currentBookmarkCount = bookmarkService.getLikeCount(targetType, targetNo);
        
        result.put("status", "success");
        result.put("isBookmarked", isBookmarked);
        result.put("bookmarkCount", currentBookmarkCount);
        
        return result;
    }

    @GetMapping("/check")
    @ResponseBody
    public boolean checkBookmark(
            @RequestParam String targetType,
            @RequestParam int targetNo,
            HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return false;

        return bookmarkService.isBookmarked(loginMember.getMemberNo(), targetType, targetNo);
    }
}
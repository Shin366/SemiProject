package com.fortrip.com.app.member.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fortrip.com.app.member.dto.MyBoard;
import com.fortrip.com.domain.member.model.service.MyPageService;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("member/myBoard")
public class MyPageController {

    private final MyPageService pService;

    @GetMapping
    public String showMyBoard(
            @RequestParam(value = "type", required = false, defaultValue = "all") String type,
            HttpSession session,
            Model model) {
        
        try {
            // 로그인 확인
            Member loginMember = (Member) session.getAttribute("loginMember");
            
            if (loginMember == null) {
                model.addAttribute("errorMsg", "로그인이 필요합니다.");
                return "member/login";
            }

            int memberNo = loginMember.getMemberNo();
            List<MyBoard> boardList;

            // 게시판 타입에 따라 조회
            switch (type) {
                case "community":
                    boardList = pService.getMyCommunityList(memberNo);
                    break;
                case "review":
                    boardList = pService.getMyReviewList(memberNo);
                    break;
                default:
                    boardList = pService.getMyAllBoardList(memberNo);
                    break;
            }

            // 디버깅용 로그
            System.out.println("조회된 게시글 수: " + (boardList != null ? boardList.size() : 0));

            model.addAttribute("boardList", boardList);
            model.addAttribute("type", type);
            model.addAttribute("member", loginMember);

            return "member/myBoard";
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
}
package com.fortrip.com.app.comment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fortrip.com.domain.comment.model.service.CommentService;
import com.fortrip.com.domain.comment.model.vo.Comment;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/board/comment")
public class CommentController {
    
    private final CommentService commentService;

    // 댓글 목록 조회
    @GetMapping("/list")
    public List<Comment> getCommentList(
            @RequestParam String boardType,
            @RequestParam int boardNo) {
        return commentService.getCommentList(boardType, boardNo);
    }

    // 댓글 등록
    @PostMapping("/insert")
    public Map<String, Object> addComment(
            Comment comment, // boardType, boardNo, commentContent 바인딩
            HttpSession session) {

        Map<String, Object> response = new HashMap<>(); // 응답용 Map 생성
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("status", "error");
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        try {
            // 서비스 호출 (서비스 내부에서 memberNo 설정)
            int result = commentService.addComment(comment, loginMember);

            if (result > 0) {
                response.put("status", "success");
            } else {
                 response.put("status", "fail");
                 response.put("message", "댓글 등록에 실패했습니다.");
            }
        } catch (Exception e) {
             response.put("status", "error");
             response.put("message", "댓글 처리 중 오류가 발생했습니다.");
        }
        return response; // JSON 객체 반환 {"status": "success"} 또는 {"status": "fail", ...}
    }
}

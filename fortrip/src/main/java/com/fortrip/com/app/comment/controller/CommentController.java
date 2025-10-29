package com.fortrip.com.app.comment.controller;

import java.util.Collections;
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

    // 댓글 조회
    @GetMapping("/list")
    public List<Comment> getCommentList(
            @RequestParam String boardType,
            @RequestParam(required = false) Integer boardNo) {

        if (boardNo == null) return Collections.emptyList();
        return commentService.getCommentList(boardType, boardNo);
    }

    // 댓글 등록
    @PostMapping("/insert")
    public Map<String, Object> addComment(Comment comment, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("status", "error");
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        try {
            int result = commentService.addComment(comment, loginMember);
            response.put("status", result > 0 ? "success" : "fail");
            if (result <= 0) response.put("message", "댓글 등록 실패");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "댓글 등록 중 오류 발생");
        }
        return response;
    }

    // 댓글 수정
    @PostMapping("/update")
    public Map<String, Object> updateComment(
            @RequestParam int commentNo,
            @RequestParam String commentContent,
            HttpSession session) {

        Map<String, Object> map = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            map.put("status", "error");
            map.put("message", "로그인이 필요합니다.");
            return map;
        }

        try {
            int result = commentService.updateComment(commentNo, commentContent, loginMember);
            map.put("status", result > 0 ? "success" : "fail");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", "error");
            map.put("message", "댓글 수정 중 오류 발생");
        }

        return map;
    }

    // 댓글 삭제
    @PostMapping("/delete")
    public Map<String, Object> deleteComment(
            @RequestParam int commentNo,
            HttpSession session) {

        Map<String, Object> map = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            map.put("status", "error");
            map.put("message", "로그인이 필요합니다.");
            return map;
        }

        try {
            int result = commentService.deleteComment(commentNo, loginMember);
            map.put("status", result > 0 ? "success" : "fail");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("status", "error");
            map.put("message", "댓글 삭제 중 오류 발생");
        }

        return map;
    }
}
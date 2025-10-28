package com.fortrip.com.app.board.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fortrip.com.domain.board.like.model.service.BoardLikeService;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class LikeController {
	
	private final BoardLikeService boardLikeService;
	
	@PostMapping("/board/like/toggle") // POST 방식 권장
    public Map<String, Object> toggleLike(
    		@RequestParam(required=false) String boardType,
    	    @RequestParam(required=false) Integer boardNo
            ,HttpSession session) {
//		
//	    System.out.println("boardType = " + boardType);
//	    System.out.println("boardNo = [" + boardNo + "]");
//
		Map<String, Object> response = new HashMap<>();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.put("status", "error");
            response.put("message", "로그인이 필요합니다.");
            return response;
        }
        if (boardNo == null) {
            response.put("status", "error");
            response.put("message", "게시글 번호가 올바르지 않습니다.");
            return response;
        }
        if (boardType == null || boardType.isBlank()) {
            response.put("status", "error");
            response.put("message", "게시판 타입 정보가 올바르지 않습니다.");
            return response;
        }


        try {
            boolean isNowLiked = boardLikeService.toggleLike(boardType, boardNo, loginMember.getMemberNo());
            int currentLikeCount = boardLikeService.getLikeCount(boardType, boardNo);

            response.put("status", "success");
            response.put("isLiked", isNowLiked);       // true = 좋아요 상태 / false = 취소됨
            response.put("likeCount", currentLikeCount); // 최신 좋아요 개수
        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "좋아요 처리 중 오류가 발생했습니다.");
        }

        return response;
    }

}

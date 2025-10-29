package com.fortrip.com.app.board.review.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.review.dto.BoardReviewAddRequest;
import com.fortrip.com.domain.board.review.model.sevice.BoardReviewService;
import com.fortrip.com.domain.board.review.model.vo.BoardReview;
import com.fortrip.com.domain.comment.model.service.CommentService;
import com.fortrip.com.domain.comment.model.vo.Comment;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/review")
@RequiredArgsConstructor
public class BoardReviewController {
	
	private final BoardReviewService reviewService;
	private final CommentService commentService;

	
	// 리뷰게시판 상세페이지
	@GetMapping("/detail")
	public String showDetailReview(
			@RequestParam("reviewNo") Integer reviewNo, 
			Model model){
		try {
            if (reviewNo == null) {
                 model.addAttribute("errorMsg", "잘못된 리뷰 번호입니다.");
                 return "common/error";
            }
			BoardReview review = reviewService.selectOneByNo(reviewNo);
			List<Comment> commentList = commentService.getCommentList("REVIEW", reviewNo);
			
			model.addAttribute("commentList", commentList);
			model.addAttribute("review", review);
			return "board/review/detail";
		} catch(IllegalArgumentException e) {
            log.warn("리뷰 상세 조회 실패: {}", e.getMessage());
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        } catch(Exception e) {
            log.error("리뷰 상세 조회 중 오류", e);
			model.addAttribute("errorMsg", "리뷰 조회 중 오류가 발생했습니다.");
			return "common/error";
		}
	}
	
	// 리뷰게시판 작성페이지 출력
	@GetMapping("/insert")
	public String showReviewInsertView(HttpSession session, Model model) { 
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "common/error"; // 또는 로그인 페이지 리다이렉트
        }
        // (추가) 작성 폼에 필요한 정보(예: road 목록)가 있다면 여기서 조회해서 전달
		 return "board/review/insert"; 
	}
	
	// 리뷰 게시판 작성페이지 실행 로직
	@PostMapping("/insert") // GetMapping -> PostMapping 변경
	public String insertReview(
			@ModelAttribute BoardReviewAddRequest review, 
			@RequestParam(value="files", required=false) List<MultipartFile> files,
			HttpSession session,
			Model model) {

		// 로그인 체크
		Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "common/error";
        }

		try {
			int result = reviewService.insertReview(review, files, loginMember);

            // 성공 시 목록 페이지로 리다이렉트
			return "redirect:/board/review/list";
		} catch(Exception e) {
            log.error("리뷰 등록 오류", e);
			model.addAttribute("errMsg","리뷰 등록 중 오류가 발생했습니다.");
			return "common/error";
		}
	}
	
	
	// 리뷰게시판 수정페이지 출력
	
	
	// 리뷰게시판 수정페이지 실행
	
	// 리뷰게시판 목록 조회
	@GetMapping("/list")
	public String showReviewListView(
			@RequestParam(value="page", defaultValue="1") int currentPage
			,Model model) {
			try {int totalCount = reviewService.getTotalCount();
			int reviewCountPerPage = 5;
			
			int maxPage = (int)Math.ceil((double)totalCount/reviewCountPerPage);
			List<BoardReview> reviewList = reviewService.selectReviewList(currentPage, reviewCountPerPage);
			
			int naviCountPerPage = 6;
			int startNavi = ((currentPage-1)/naviCountPerPage)*naviCountPerPage+1;	// 네비의 시작값
			int endNavi = (startNavi-1)+naviCountPerPage;							// 네비의 끝값
			if(endNavi > maxPage) endNavi = maxPage;
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("reviewList", reviewList);
			
			return "board/review/list";
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
}

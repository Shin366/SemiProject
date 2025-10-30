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
import com.fortrip.com.app.board.review.dto.BoardReviewUpdateRequest;
import com.fortrip.com.domain.attachment.service.AttachmentService;
import com.fortrip.com.domain.attachment.vo.Attachment;
import com.fortrip.com.domain.board.bookmark.model.service.BookmarkService;
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
	private final AttachmentService attachmentService;
	private final BookmarkService bookmarkService;
	
	// 리뷰게시판 상세페이지
	@GetMapping("/detail")
	public String showDetailReview(
			@RequestParam("reviewNo") Integer reviewNo, 
			HttpSession session,
			Model model){
		try {
            if (reviewNo == null) {
                 model.addAttribute("errorMsg", "잘못된 리뷰 번호입니다.");
                 return "common/error";
            }
            //  리뷰 게시글 
			BoardReview review = reviewService.selectOneByNo(reviewNo);
			
			// 댓글 목록
			List<Comment> commentList = commentService.getCommentList("REVIEW", reviewNo);
			model.addAttribute("commentList", commentList);
			
			// 로그인한 사용자
			Member loginMember = (Member)session.getAttribute("loginMember");
			
			// 북마크 조회
			boolean isBookmarked = false;
	        int bookmarkCount = bookmarkService.getLikeCount("REVIEW", reviewNo);
	        if (loginMember != null) {
	            isBookmarked = bookmarkService.isBookmarked(loginMember.getMemberNo(), "REVIEW", reviewNo);
	        }
			
			
	        model.addAttribute("review", review);
	        model.addAttribute("bookmarkCount", bookmarkCount);
	        model.addAttribute("isBookmarked", isBookmarked);
			
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
            return "common/error";
        }
        // (추가) 작성 폼에 필요한 정보(예: road 목록)가 있다면 여기서 조회해서 전달
		 return "board/review/insert"; 
	}
	
	// 리뷰 게시판 작성페이지 실행 로직
	@PostMapping("/insert")
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
            model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	// 리뷰게시판 수정페이지 출력
	@GetMapping("/update")
	public String showModifyReview(
	        @RequestParam("reviewNo") int reviewNo,
	        HttpSession session,
	        Model model) {

	    try {
	        Member loginMember = (Member) session.getAttribute("loginMember");
	        if (loginMember == null) {
	            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
	            return "common/error";
	        }

	        // 게시글 조회
	        BoardReview review = reviewService.selectOneByNo(reviewNo);
	        if (review == null) {
	            model.addAttribute("errorMsg", "존재하지 않는 게시글입니다.");
	            return "common/error";
	        }

	        // 작성자 확인
	        if (review.getMemberNo() != loginMember.getMemberNo()) {
	            model.addAttribute("errorMsg", "본인 게시글만 수정할 수 있습니다.");
	            return "common/error";
	        }

	        // 첨부파일 목록 조회
	        List<Attachment> attachmentList = attachmentService.getAttachmentsByBoard("REVIEW", reviewNo);

	        model.addAttribute("review", review);
	        model.addAttribute("attachmentList", attachmentList);
	        return "board/review/update";

	    } catch (Exception e) {
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
	}

	// 리뷰게시판 수정 실행
	@PostMapping("/update")
	public String updateReview(
	        @ModelAttribute BoardReviewUpdateRequest reviewUpdateDto,
	        @RequestParam(value = "reloadFiles", required = false) List<MultipartFile> reloadFiles,
	        @RequestParam(value = "deletedFiles", required = false) List<Integer> deletedFiles,
	        HttpSession session,
	        Model model) {

	    try {
	        Member loginMember = (Member) session.getAttribute("loginMember");
	        if (loginMember == null) {
	            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
	            return "common/error";
	        }

	        int result = reviewService.updateReview(reviewUpdateDto, reloadFiles, deletedFiles, loginMember);

	        if (result > 0) {
	            return "redirect:/board/review/detail?reviewNo=" + reviewUpdateDto.getReviewNo();
	        } else {
	            model.addAttribute("errorMsg", "리뷰 수정 실패");
	            return "common/error";
	        }

	    } catch (Exception e) {
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
	}

	
	// 리뷰게시판 삭제
	@GetMapping("/delete")
	public String deleteReview(@RequestParam("reviewNo") int reviewNo
			, HttpSession session) {
		
		// 로그인 확인
		Member loginMember = (Member)session.getAttribute("loginMember");
		// 이미지 전체 삭제
		
		// 게시글 삭제
		reviewService.deleteReview(reviewNo, loginMember);
		
		// 삭제 후 목록으로 리다이렉트
		return "redirect:/board/review/list";
	}
	
	
	// 리뷰게시판 목록 조회
	@GetMapping("/list")
	public String showReviewListView(
			@RequestParam(value="page", defaultValue="1") int currentPage
			,Model model) {
			try {int totalCount = reviewService.getTotalCount();
			int reviewCountPerPage = 4;
			
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

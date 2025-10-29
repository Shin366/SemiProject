package com.fortrip.com.app.board.free.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.free.dto.BoardFreeAddRequest;
import com.fortrip.com.app.board.free.dto.BoardFreeUpdateRequest;
import com.fortrip.com.domain.attachment.service.AttachmentService;
import com.fortrip.com.domain.attachment.vo.Attachment;
import com.fortrip.com.domain.board.free.model.service.BoardFreeService;
import com.fortrip.com.domain.board.free.model.vo.BoardFree;
import com.fortrip.com.domain.board.like.model.service.BoardLikeService;
import com.fortrip.com.domain.board.notice.model.service.BoardNoticeService;
import com.fortrip.com.domain.board.notice.model.vo.BoardNotice;
import com.fortrip.com.domain.comment.model.service.CommentService;
import com.fortrip.com.domain.comment.model.vo.Comment;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board/free")
@RequiredArgsConstructor
public class BoardFreeController {
	
	private final BoardFreeService fService;
	private final BoardNoticeService nService;
	private final AttachmentService attachmentService;
	private final CommentService commentService;
	private final BoardLikeService likeService;
	
	// 자유게시판 상세페이지
	@GetMapping("/detail")
	public String showDetailView(
			@RequestParam("postNo") int postNo
			,HttpSession session
			,Model model) {
		try {
			
			Member loginMember = (Member) session.getAttribute("loginMember");
			
			 if (loginMember == null) {
		            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
		            return "common/error"; // 또는 로그인 페이지로 리다이렉트
		        }
			// 게시글 조회
			BoardFree free = fService.selectOneByNo(postNo);
			
			//첨부파일 조회
			List<Attachment> attachmentList = attachmentService.getAttachmentsByBoard("FREE", postNo);
			
			 //조회수 증가
			 fService.increaseViewCount(postNo);
			
			 // 좋아요, 댓글 정보 조회 및 모델에 추가
             int likeCount = likeService.getLikeCount("FREE", postNo);
             boolean isLiked = likeService.checkIsLiked("FREE", postNo, loginMember.getMemberNo());
            
             model.addAttribute("free", free);	
             // 첨부파일 저장 코드
			model.addAttribute("attachmentList", attachmentList);
             
             List<Comment> commentList = commentService.getCommentList("FREE", postNo);
             model.addAttribute("likeCount", likeCount);
             model.addAttribute("isLiked", isLiked);
             model.addAttribute("commentList", commentList);
			return "board/free/detail";
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
			
		}
	}
	
	// 자유게시판 작성페이지 출력
	@GetMapping("/insert")
	public String showFreeAddView(
			HttpSession session, Model model) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		if (loginMember == null) { 
	        model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
	        return "common/error";
	    }
	    return "board/free/insert";
	}
	
	
	// 자유게시판 작성페이지 실행로직
	@PostMapping("/insert")
	public String insertFree(
			@ModelAttribute BoardFreeAddRequest free
			,@RequestParam(value="files", required=false) List<MultipartFile> files
			,HttpSession session
			,Model model) {
		
		Member loginMember = (Member) session.getAttribute("loginMember");  
		
		// (보안) 비로그인 사용자가 글쓰기를 시도한 경우 차단
        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "common/error"; // 또는 로그인 페이지로 리다이렉트
        }
		try {
			 int result = fService.insertFree(free, files, loginMember);
			return "redirect:/board/free/list";
		}catch(Exception e) {
			model.addAttribute("errMsg",e.getMessage());
			return "common/error";
		}
	}
	// 자유게시판 수정페이지 출력
	@GetMapping("/update")
	public String showModifyView(
			@RequestParam int postNo
			,HttpSession session
			,Model model) {
		try{
			BoardFree free = fService.selectOneByNo(postNo);
			model.addAttribute("free", free);
			return "/board/free/update";
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	// 자유게시판 수정 구현
	@PostMapping("/update")
	public String updateFreeOne(
			@ModelAttribute BoardFreeUpdateRequest free,
	        @RequestParam(value="reloadFiles", required=false) List<MultipartFile> reloadFiles,
	        // 추가: 삭제할 파일의 attachNo 목록을 받음
	        @RequestParam(value="deletedFiles", required=false) List<Integer> deletedFiles,
	        HttpSession session,
	        Model model
			) {
		// 로그인 정보 가져오기
		Member loginMember = (Member) session.getAttribute("loginMember");

	    // (보안) 비로그인 사용자 차단
	    if (loginMember == null) {
	        model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
	        return "common/error";
	    }
		
		try {
	        // 서비스에 삭제할 파일 ID 목록도 함께 전달
			int result = fService.updateBoardFree(free, reloadFiles, deletedFiles, loginMember);
	        return "redirect:/board/free/detail?postNo=" + free.getPostNo();
	    } catch (Exception e) {
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
		
	}
	
	// 게시글 삭제 구현
	@GetMapping("/delete")
    public String deleteFree(@RequestParam("postNo") int postNo) {
        // 첨부파일 전체 삭제
        attachmentService.deleteAttachmentsByBoard("FREE", postNo);

        // 게시글 삭제
        fService.deleteFree(postNo);

        // 삭제 후 목록으로 리다이렉트
        return "redirect:/board/free/list";
    }	
	
	@GetMapping("/list")
	public String showBoardListView(
	        @RequestParam(value = "page", defaultValue = "1") int currentPage,
	        @RequestParam(value = "condition", required = false) String condition,
	        @RequestParam(value = "keyword", required = false) String searchKeyword,
	        Model model) {

	    try {
	        // ===== 검색 조건 처리 =====
	        Map<String, Object> searchMap = new HashMap<>();
	        searchMap.put("condition", condition);
	        searchMap.put("searchKeyword", searchKeyword);
	        searchMap.put("page", currentPage);

	        // ===== 검색어 로그 저장 (선택) =====
	        if (searchKeyword != null && !searchKeyword.isBlank()) {
	            fService.insertSearchKeyword(searchKeyword);
	        }

	        // ===== 고정 공지 가져오기 =====
	        try {
	            int pinnedNoticeNo = 1;
	            BoardNotice pinnedNotice = nService.getBasicNoticeInfo(pinnedNoticeNo);
	            model.addAttribute("pinnedNotice", pinnedNotice);
	        } catch (Exception ignore) {
	            // 공지가 없어도 예외 무시
	        }

	        // ===== 게시글 목록 + 페이징 =====
	        int totalCount = fService.getTotalCount(searchMap); // 검색 조건 반영된 전체 개수
	        int freeCountPerPage = 5;

	        int maxPage = (int) Math.ceil((double) totalCount / freeCountPerPage);
	        if (currentPage > maxPage && maxPage != 0) currentPage = maxPage;

	        List<BoardFree> fList = fService.searchFreeBoardList(searchMap); // 검색 또는 전체 조회

	        int naviCountPerPage = 6;
	        int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
	        int endNavi = (startNavi - 1) + naviCountPerPage;
	        if (endNavi > maxPage) endNavi = maxPage;

	        // ===== 모델 등록 =====
	        model.addAttribute("fList", fList);
	        model.addAttribute("condition", condition);
	        model.addAttribute("searchKeyword", searchKeyword);
	        model.addAttribute("currentPage", currentPage);
	        model.addAttribute("maxPage", maxPage);
	        model.addAttribute("startNavi", startNavi);
	        model.addAttribute("endNavi", endNavi);

	        return "board/free/list";

	    } catch (Exception e) {
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
	}
	
}

package com.fortrip.com.app.board.free.controller;

import java.util.List;

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
		if (session.getAttribute("memberId") == null) { 
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
	
	// 자유게시판 목록 조회
	@GetMapping("/list")
	public String showBoardListView(
			@RequestParam(value="page", defaultValue="1") int currentPage
			,Model model) {
		try{
			
			// 게시글 목록 상단 고정 공지 출력
            try {
                // 고정할 공지사항의 번호 지정
                int pinnedNoticeNo = 1; 
                // 3. NoticeService를 이용해 해당 공지 데이터 조회
                BoardNotice pinnedNotice = nService.getBasicNoticeInfo(pinnedNoticeNo);
                // 4. 조회된 공지 객체를 Model에 담기 ("pinnedNotice" 라는 이름으로)
                model.addAttribute("pinnedNotice", pinnedNotice); 
            } catch (IllegalArgumentException e) {
            	model.addAttribute("errorMsg", e.getMessage());
    	        return "common/error";
            }
			
			int totalCount = fService.getTotalCount();
			int freeCountPerPage = 5;
			
			int maxPage = (int)Math.ceil((double)totalCount/freeCountPerPage);
			List<BoardFree> fList = fService.selectFreeList(currentPage, freeCountPerPage);
			
			int naviCountPerPage = 6;
			int startNavi = ((currentPage-1)/naviCountPerPage)*naviCountPerPage+1;	// 네비의 시작값
			int endNavi = (startNavi-1)+naviCountPerPage;							// 네비의 끝값
			if(endNavi > maxPage) endNavi = maxPage;
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("fList", fList);
			
			return "board/free/list";
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
}

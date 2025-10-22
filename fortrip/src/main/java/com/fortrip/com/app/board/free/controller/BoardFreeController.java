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
import com.fortrip.com.domain.board.free.model.service.BoardFreeService;
import com.fortrip.com.domain.board.free.model.vo.BoardFree;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/free")
@RequiredArgsConstructor
public class BoardFreeController {
	
	private final BoardFreeService fService;
	
	// 자유게시판 상세페이지
	@GetMapping("/detail")
	public String showDetailView(
			int freeNo
			,Model model) {
		try {
			BoardFree free = fService.selectOneByNo(freeNo);
			model.addAttribute("free", free);
			return "board/free/detail";
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
			
		}
	}
	
	// 자유게시판 작성페이지 출력
	@GetMapping("/insert")
	public String showFreeAddView() {
		return "board/free/insert";
	}
	
	
	// 자유게시판 작성페이지 실행로직
	@PostMapping("/insert")
	public String insertFree(
			@ModelAttribute BoardFreeAddRequest free
			,@RequestParam(value="files", required=false) List<MultipartFile> files
			,HttpSession session
			,Model model) {
		/* member import 후 주석 해제
		// 로그인 상태 체크
		Member loginMember = (Member) session.getAttribute("loginMember");  
		
		// 3. (보안) 비로그인 사용자가 글쓰기를 시도한 경우 차단
        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "common/error"; // 또는 로그인 페이지로 리다이렉트
        }
		 */		
		try {
			/* memberVo import 후 주석 해제 
			 int result = fService.insertFree(free, files, loginMember);
			 */
			int result = fService.insertFree(free, files);
			return "redirect:/free/list";
		}catch(Exception e) {
			model.addAttribute("errMsg",e.getMessage());
			return "common/error";
		}
	}
	
	// 자유게시판 목록 조회
	@GetMapping("/list")
	public String showBoardListView(
			@RequestParam(value="page", defaultValue="1") int currentPage
			,Model model) {
		try{
			int totalCount = fService.getTotalCount();
			int freeCountPerPage = 5;
			/*
			 * int maxPage = totalCount % freeCountPerPage != 0
									? totalCount/freeCountPerPage + 1
											: totalCount / freeCountPerPage;
											*/
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

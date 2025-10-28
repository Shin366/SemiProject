package com.fortrip.com.app.board.notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fortrip.com.app.board.notice.dto.BoardNoticeDetailDTO;
import com.fortrip.com.domain.board.notice.model.service.BoardNoticeService;
import com.fortrip.com.domain.board.notice.model.vo.BoardNotice;

@Controller
@RequestMapping("/board/notice")
public class BoardNoticeController {
	
	@Autowired
	private BoardNoticeService nService;
	
	// 공지사항 세부
	@GetMapping("/detail")
	public String showNoticeDetailView(
			@RequestParam("noticeNo") 
			int noticeNo
			,Model model) {
		try {
			// 1. Service로부터 BoardNoticeDetailDTO 타입으로 결과를 받습니다.
	        BoardNoticeDetailDTO detailDto = nService.selectOneByNo(noticeNo); 
	        
	        // 2. DTO 객체 전체를 "detail"이라는 이름으로 Model에 담습니다.
	        model.addAttribute("detail", detailDto);
			return "board/notice/detail";
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	// 공지사항 목록 조회
	@GetMapping("/list")
	public String showNoticeList(
			@RequestParam(value="page", defaultValue="1") int currentPage
			,Model model) {
		try {
			int totalCount = nService.getTotalCount();			// 전체 게시물 갯수
			int boardCountPerPage = 5;		// 한 페이지당 보여주는 게시물의 갯수
			int maxPage = totalCount % boardCountPerPage != 0 
								? totalCount/boardCountPerPage + 1 
										: totalCount/boardCountPerPage;				// 전체 페이지 수
			maxPage = (int)Math.ceil((double)totalCount/boardCountPerPage); 
			
			
			List<BoardNotice> nList = nService.selectList(currentPage, boardCountPerPage);
			int naviCountPerPage = 5;		// 한 페이징당 보여주는 페이지의 갯수
			// currentPage: 1 ~ 5, startNavi: 1, endNavi: 5*1
			// currentPage: 6 ~ 10, startNavi: 6, endNavi: 10 = 5*2
			// currentPage: 11 ~ 15, startNavi: 11, endNavi: 15 = 5*3			
			int startNavi = ((currentPage-1)/naviCountPerPage)*naviCountPerPage+1;	// 네비의 시작값
			int endNavi = (startNavi-1)+naviCountPerPage;							// 네비의 끝값
			if(endNavi > maxPage) endNavi = maxPage;
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("nList", nList);
			
			return "board/notice/list";
			
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	/*
	// 공지사항 검색 구현 예정
	@GetMapping("/search")
	public String showNoticeSearchList() {
		
	}
	*/

}

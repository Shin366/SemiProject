package com.fortrip.com.app.board.qna.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.qna.dto.BoardQnaAddRequest;
import com.fortrip.com.app.board.qna.dto.BoardQnaUpdateRequest;
import com.fortrip.com.domain.board.qna.model.service.BoardQnaService;
import com.fortrip.com.domain.board.qna.model.vo.BoardQna;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board/qna")
public class BoardQnaController { // 문의게시판 컨트롤러
	
	@Autowired
	private BoardQnaService qService;
	
	@GetMapping("/list")
	// 문의게시판 목록 조회
	public String showQnaList(
			@RequestParam(value="page", defaultValue="1") int currentPage
			,Model model) {
		try {
			int totalCount = qService.getTotalCount();			// 전체 게시물 갯수
			int boardCountPerPage = 5;		// 한 페이지당 보여주는 게시물의 갯수
			int maxPage = totalCount % boardCountPerPage != 0 
								? totalCount/boardCountPerPage + 1 
										: totalCount/boardCountPerPage;				// 전체 페이지 수
			maxPage = (int)Math.ceil((double)totalCount/boardCountPerPage); 
			List<BoardQna> qList = qService.selectQnaList(currentPage, boardCountPerPage);
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
			model.addAttribute("qList", qList);
			return "board/qna/list";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	// 문의게시판 상세페이지
	@GetMapping("/detail")
	public String showDetailView(
			int qnaNo
			,Model model) {
		try {
			BoardQna boardQna = qService.selectOneByNo(qnaNo);
			 
			model.addAttribute("boardQna", boardQna);
			return "board/qna/detail"; 
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
		
	}
	
	@PostMapping("/delete")
	// 문의게시판 삭제
	public String deleteQnaOne(
			@RequestParam int qnaNo
			,Model model) {
		try {
			int result = qService.deleteQna(qnaNo);
			return "redirect:/board/qna/list";
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	@GetMapping("/update")
	// 문의게시판 수정
	public String showUpdateView(
			@RequestParam int qnaNo
			,HttpSession session
			,Model model) {
		try {
			BoardQna boardQna = qService.selectOneByNo(qnaNo);
			model.addAttribute("boardQna", boardQna);
			return "board/qna/update";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	@PostMapping("/update")
	public String updateQnaOne(
			@ModelAttribute BoardQnaUpdateRequest qna,
	        @RequestParam(value="reloadFiles", required=false) List<MultipartFile> reloadFiles,
	        // 추가: 삭제할 파일의 attachNo 목록을 받음
	        @RequestParam(value="deletedFiles", required=false) List<Integer> deletedFiles,
	        Model model) {
	    
	    try {
	        // 서비스에 삭제할 파일 ID 목록도 함께 전달
	        int result = qService.updateBoardQna(qna, reloadFiles, deletedFiles);
	        return "redirect:/board/qna/detail?qnaNo=" + qna.getQnaNo();
	    } catch (Exception e) {
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
	}
	
	// 문의게시판 작성
	@GetMapping("/insert")
	public String showQnaAddView() {
		return "board/qna/insert";
	}
	
	@PostMapping("/insert")
	public String insertQna(
			@ModelAttribute BoardQnaAddRequest qna
			,@RequestParam(value="files", required=false) List<MultipartFile> files
			,Model model) {
		try {
			int result = qService.insertQna(qna, files);
			return "redirect:/board/qna/list"; // 등록이 완료되고 나서 이동할 페이지	
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	// 문의게시판 검색 - 구현 예정
	
	

}

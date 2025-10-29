package com.fortrip.com.app.admin.notice.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;
import com.fortrip.com.app.admin.notice.dto.NoticeModifyDTO;
import com.fortrip.com.domain.admin.notice.model.service.NoticeService;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {
	
	private final NoticeService nService;
	/* 공지 삽입 페이지 이동 */
	@GetMapping("/insert")
	public String noticePage() {
		return "admin/notice/noticeInsert";
	}
	
	/* 공지 삽입 */
	@PostMapping("/insert")
	public String noticeInsert(@ModelAttribute NoticeInsertDTO notice			
			,Model model, HttpSession session) {
		try {
			int result = nService.insertNotice(notice);
			return "admin/notice/noticeInsert";
		} catch (Exception e) {
			e.printStackTrace();
			return "admin/notice/noticeInsert";
		}
	}
	/* 공지 수정 이동 */
	@GetMapping("/modify")
	public String noticeModify(@RequestParam("noticeNo")int noticeNo, Model model) {
		NoticeVO notice = nService.noticeInfoModify(noticeNo);
		model.addAttribute("noticeInfo", notice);
		return "admin/notice/noticemodify";
	}
	/* 공지 수정 저장 */
	@PostMapping("/modify")
	public String noticeModifySave(@ModelAttribute NoticeModifyDTO notice, Model model) {
		try {
			int result = nService.noticeModify(notice);
			return "redirect:/admin/main";
		} catch(Exception e) {
			e.printStackTrace();
			return "/admin/notice/noticemodify";		
		}
	}
	/* 공지 리스트 fetch API */
	@ResponseBody
	@GetMapping("/list")
	public Map<String, Object> noticeList(@RequestParam("page")int currentPage) {
		int totalCount = nService.getNoticeTotalCount();
		int noticeCountPerPage = 3; 
		List<NoticeVO> nList = nService.AllnoticeList(currentPage, noticeCountPerPage);
		System.out.println(nList);
		int maxPage = (int)Math.ceil((double)totalCount/ noticeCountPerPage);
		int naviPerPageCount = 3;
		
		int startNavi = ((currentPage - 1)/naviPerPageCount) * naviPerPageCount + 1;
		int endNavi = (startNavi-1)+naviPerPageCount;
		if(endNavi > maxPage) {endNavi = maxPage;}

		Map<String, Object> result = new HashMap<>();
		result.put("nList", nList);
		result.put("startNavi", startNavi);
		result.put("endNavi", endNavi);
		result.put("currentPage", currentPage);
		result.put("maxPage", maxPage);
		
		return result;
	}
	
	/* 공지 리스트 검색 fetch API */
	@ResponseBody
	@PostMapping("/search/list")
	public Map<String, Object> searchNoticeList(@RequestParam("page")int currentPage,
			@RequestParam("keyword")String keyword) {
		int totalCount = nService.getNoticeSearchCount(keyword);
		int noticeCountPerPage = 3; 
		List<NoticeVO> nList = nService.SearchNoticeList(currentPage, noticeCountPerPage, keyword);
		
		int maxPage = (int)Math.ceil((double)totalCount/ noticeCountPerPage);
		int naviPerPageCount = 3;
		
		int startNavi = ((currentPage - 1)/naviPerPageCount) * naviPerPageCount + 1;
		int endNavi = (startNavi-1)+naviPerPageCount;
		if(endNavi > maxPage) {endNavi = maxPage;}

		Map<String, Object> result = new HashMap<>();
		result.put("keyword", keyword);
		result.put("nList", nList);
		result.put("startNavi", startNavi);
		result.put("endNavi", endNavi);
		result.put("currentPage", currentPage);
		result.put("maxPage", maxPage);
		
		return result;
	}
	
	/* 공지 삭제 fetch API */
	@ResponseBody
	@GetMapping("/delete")
	public int noticeDelete(@RequestParam("noticeNo") int noticeNo) {
		int result = nService.noticeDelete(noticeNo);
		return result;
	}

}

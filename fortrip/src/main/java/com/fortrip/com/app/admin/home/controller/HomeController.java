package com.fortrip.com.app.admin.home.controller;

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
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fortrip.com.app.admin.home.dto.GetMemberDTO;
import com.fortrip.com.domain.admin.home.model.service.MemberInfoService;
import com.fortrip.com.domain.admin.home.model.vo.MemberVO;
import com.fortrip.com.domain.admin.notice.model.service.NoticeService;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;
import com.fortrip.com.domain.admin.qna.model.service.QnAService;
import com.fortrip.com.domain.admin.qna.model.vo.QnAVO;
import com.fortrip.com.domain.admin.question.model.service.QuestionService;
import com.fortrip.com.domain.admin.question.model.vo.QuestionVO;
import com.fortrip.com.domain.admin.report.model.service.ReportService;
import com.fortrip.com.domain.admin.road.model.service.RoadService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class HomeController {
	private final MemberInfoService mService;
	private final QuestionService qService;
	private final NoticeService nService;
	private final RoadService rService;
	private final ReportService roService;
	
	@GetMapping("/main")
    public String homePage(Model model, @RequestParam(value="page", defaultValue = "1") int currentPage) {
       try {
          /* 전체 회원 수 */
          int getMemberCount = mService.getMemberCount();
         
          /* 활성 회원 수 */
          int getMemberActive = mService.getMemberActive();
         
          /* 활동 정지 회원 수 */
          int getMemberStop = mService.getMemberStop();
         
          /* 공지사항 총 게시물 */
          int getNoticeCount = nService.getNoticeTotalCount();
         
          /* 문의글 총 게시물 */
          int getQuestionCount = qService.getQuestionTotalCount();
         
          /* 여행 코스 총 갯수 */
          int getTravelCourseCount = rService.getTravelCourseCount();
         
          /* 신고 게시물 총 갯수 */
          int getReportCount = roService.getReportCount();
          
          model.addAttribute("getReportCount", getReportCount);
          model.addAttribute("getTravelCourseCount", getTravelCourseCount);
          model.addAttribute("getQuestionCount", getQuestionCount);
          model.addAttribute("getNoticeCount", getNoticeCount);
          model.addAttribute("getMemberCount", getMemberCount);
          model.addAttribute("getMemberActiveCount", getMemberActive);
          model.addAttribute("getMemberStopCount", getMemberStop);         
          return "admin/admin";
         
       } catch (Exception e) {
          e.printStackTrace();
          return "admin/admin";
       }
    }
	
	/* 회원 리스트 fetch API */
	@ResponseBody
	@GetMapping("/user/list")
	public Map<String, Object> userList(@RequestParam("page") int currentPage) {
		int totalCount = mService.getTotalCount();
		int naviCountPerPage = 3;
		int userCountPerPage = 3;
		
		List<MemberVO> mList = mService.userList(currentPage, userCountPerPage);
		int maxPage = (int)Math.ceil((double)totalCount / userCountPerPage);
		
		int startNavi = ((currentPage-1)/naviCountPerPage) * naviCountPerPage + 1;
		int endNavi = (startNavi-1)+naviCountPerPage;
		if(endNavi > maxPage) {endNavi = maxPage;}
		
		Map<String, Object> result = new HashMap<>();
		result.put("mList", mList);
		result.put("startNavi", startNavi);
		result.put("endNavi", endNavi);
		result.put("currentPage", currentPage);
		result.put("maxPage", maxPage);
		
		return result;
	}
	
	/* 회원 리스트 검색 fetch API */
	@ResponseBody
	@PostMapping("/user/search")
	public Map<String, Object> searchUserList(@RequestParam("page") int currentPage,
			@RequestParam("keyword") String keyword) {
		int totalCount = mService.getSearchCount(keyword);
		int naviCountPerPage = 3;
		int userCountPerPage = 3;
		
		List<MemberVO> mList = mService.userSearchList(currentPage, userCountPerPage, keyword);
		int maxPage = (int)Math.ceil((double)totalCount / userCountPerPage);
		
		int startNavi = ((currentPage-1)/naviCountPerPage) * naviCountPerPage + 1;
		int endNavi = (startNavi-1)+naviCountPerPage;
		if(endNavi > maxPage) {endNavi = maxPage;}
		
		Map<String, Object> result = new HashMap<>();
		result.put("keyword", keyword);
		result.put("mList", mList);
		result.put("startNavi", startNavi);
		result.put("endNavi", endNavi);
		result.put("currentPage", currentPage);
		result.put("maxPage", maxPage);
		
		return result;
	}
	
	/* 회원 검색 필터(비활성, 활성, 남자, 여자 구분) fetch API */
	@ResponseBody
	@PostMapping("/user/filter")
	public Map<String, Object> userFillerList(@RequestParam("filter")String filter,
			@RequestParam("page")int currentPage) {
		int totalCount = mService.getfillterCount(filter);
		int naviCountPerPage = 3;
		int userCountPerPage = 3;
		
		List<MemberVO> mList = mService.userfillterList(currentPage, userCountPerPage, filter);
		int maxPage = (int)Math.ceil((double)totalCount / userCountPerPage);
		
		int startNavi = ((currentPage-1)/naviCountPerPage) * naviCountPerPage + 1;
		int endNavi = (startNavi-1)+naviCountPerPage;
		if(endNavi > maxPage) {endNavi = maxPage;}
		
		Map<String, Object> result = new HashMap<>();
		result.put("filter", filter);
		result.put("mList", mList);
		result.put("startNavi", startNavi);
		result.put("endNavi", endNavi);
		result.put("currentPage", currentPage);
		result.put("maxPage", maxPage);
		
		return result;
	}
	
	/* 회원 강제 탈퇴 */
	@ResponseBody
	@GetMapping("/user/delete")
	public int userDelete(@RequestParam("memberNo") int memberNo) {
		int result = mService.userDelete(memberNo);
		return result;
	}
	
	/* 회원 가입자 월별 차트 */
	@ResponseBody
	@GetMapping("/signup/chart")
	public List<Map<String, Object>> getSignupChart() {
		List<Map<String, Object>> chartList = mService.getSignupChart();
		return chartList;
	}
	
	/* 인기 키워드 */
	@ResponseBody
	@GetMapping("/hot/keyword")
	public List<Map<String, Object>> getHotKeyWord() {
		List<Map<String, Object>> keywordList = mService.getHotKeyWord();
		return keywordList;
	}
}

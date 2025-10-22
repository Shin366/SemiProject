package com.fortrip.com.app.admin.home.controller;

import java.util.List;

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

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class HomeController {
	private final MemberInfoService mService;
	private final QuestionService qService;
	private final NoticeService nService;
	private final QnAService qnaService;
	
	@GetMapping("/main")
   public String homePage(Model model, @RequestParam(value="page", defaultValue = "1") int currentPage) {
      try {
         /* 전체 회원 수 */
         int getMemberCount = mService.getMemberCount();
         /* 활성 회원 수 */
         int getMemberActive = mService.getMemberActive();
         /* 활동 정지 회원 수 */
         int getMemberStop = mService.getMemberStop();
         
         /* 회원 전체 가져오기 */
         int totalCount = mService.getTotalCount();
         int memberCountPerPage = 3;
         int maxPage = (int)Math.ceil((double)totalCount/memberCountPerPage);
         List<MemberVO> mList = mService.getAllMember(currentPage, memberCountPerPage);
         int naviCountPerPage = 3;
         
         int startNavi = ((currentPage-1)/naviCountPerPage) * naviCountPerPage + 1;
         int endNavi = (startNavi-1) + naviCountPerPage;
         if(endNavi > maxPage) {endNavi = maxPage;}
         model.addAttribute("currentPage", currentPage);
         model.addAttribute("maxPage", maxPage);
         model.addAttribute("startNavi", startNavi);
         model.addAttribute("endNavi", endNavi);
         model.addAttribute("mList", mList);
         model.addAttribute("getMemberCount", getMemberCount);
         model.addAttribute("getMemberActiveCount", getMemberActive);
         model.addAttribute("getMemberStopCount", getMemberStop);         
         return "admin/admin";
         
      } catch (Exception e) {
         e.printStackTrace();
         return "admin/admin";
      }
   }
	/* 자주하는 질문 리스트 fetch API */
	@ResponseBody
	@GetMapping("/question/list")
	public List<QuestionVO> questionList() {
		List<QuestionVO> qList = qService.AllquestionList();
		return qList;
	}
	
	/* 자주하는 질문 삭제 fetch API */
	@ResponseBody
	@PostMapping("/question/detele")
	public int questionDelete(@RequestParam("questionNo") int questionNo) {
		int result = qService.questionDelete(questionNo);
		return result;
	}
	
	/* 공지 리스트 fetch API */
	@ResponseBody
	@GetMapping("/notice/list")
	public List<NoticeVO> noticeList() {
		List<NoticeVO> nList = nService.AllnoticeList();
		return nList;
	}
	
	/* 문의 게시판 리스트 fetch API */
	@ResponseBody
	@GetMapping("/qna/list")
	public List<QnAVO> qnaList() {
		List<QnAVO> qList = qnaService.AllqnaList();
		System.out.println("문의 게시판 "+qList);
		return qList;
	}
}

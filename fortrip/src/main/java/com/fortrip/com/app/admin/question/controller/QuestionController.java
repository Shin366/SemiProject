package com.fortrip.com.app.admin.question.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.question.model.service.QuestionService;
import com.fortrip.com.domain.admin.question.model.vo.QuestionVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/question")
@RequiredArgsConstructor
public class QuestionController {
	
	private final QuestionService qService;
	
	/* 자주하는 질문 삽입 페이지 이동 */
	 @GetMapping("/insert")
	 public String questionPage() {
		 return"admin/question/questionInsert";
	 }
	 
	 /* 자주하는 질문 삽입 */ /*RedirectAttributes 리다이렉트로 성공 메세지 보내기*/
	 @PostMapping("/insert")
	 public String questionSet(@ModelAttribute QuestionDTO question, Model model,
			 RedirectAttributes redirectModel) {
		 try {
			 int result = qService.questionInsert(question);
			 System.out.println(result);
			 if(result > 0) {
				 model.addAttribute("QuestionSuccess", "질문 추가 성공");
				 return "admin/question/questionInsert";
			 } else {
				 model.addAttribute("QuestionError", "질문 추가 실패");
				 return "admin/question/questionInsert";
			 }
		 } catch (Exception e) {
			 e.printStackTrace();
			 return "question/questionInsert";
		 }
	 }
	 
	/* 자주하는 질문 리스트 fetch API */
	@ResponseBody 
	@GetMapping("/list")
	public List<QuestionVO> questionList(@RequestParam("category") String category) {
		List<QuestionVO> qList = qService.getQuestionList(category);
		return qList;
	}
	
	/* 자주하는 질문 삭제 */
	@ResponseBody
	@GetMapping("/delete")
	public int questionDelete(@RequestParam("questionNo")int questionNo) {
		System.out.println("con" + questionNo);
		int result = qService.questionDelete(questionNo);
		return result;
	}
	
	/* 자주하는 질문 수정 */
	@GetMapping("/modify")
	public String questionModify(@RequestParam("questionNo")int questionNo, Model model) {
		try {
			QuestionVO question = qService.selectQuestionNo(questionNo);
			model.addAttribute("q", question);	
			return "admin/question/questionmodify";
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("ModifyError", "질문 수정 실패");
			return "admin/question/questionmodify";
		}
	}
}

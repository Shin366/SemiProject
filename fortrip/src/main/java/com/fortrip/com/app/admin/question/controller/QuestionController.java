package com.fortrip.com.app.admin.question.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.question.model.service.QuestionService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/question")
@RequiredArgsConstructor
public class QuestionController {
	
	private final QuestionService qService;
	
	 @GetMapping("/insert")
	 public String questionPage() {
		 return"admin/question/questionInsert";
	 }
	 
	 @PostMapping("/insert")
	 public String questionSet(@ModelAttribute QuestionDTO question, Model model) {
		 try {
			 int result = qService.questionInsert(question);
			 
			 if(result > 0) {
				 model.addAttribute("success", "질문 추가 성공");
			 } else {
				 model.addAttribute("error", "질문 추가 실패");
			 }
			 return "question/questionInsert";
		 } catch (Exception e) {
			 e.printStackTrace();
			 return "question/questionInsert";
		 }
	 }
}

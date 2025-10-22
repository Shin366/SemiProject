package com.fortrip.com.app.board.faq.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fortrip.com.domain.board.faq.model.service.BoardFaqService;
import com.fortrip.com.domain.board.faq.model.vo.BoardFaq;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class FaqController {

	private final BoardFaqService fService;
	
	@GetMapping("/faq")
    public String showFaqListView(Model model) {
        // 1. 서비스에서 모든 FAQ 목록을 조회
        List<BoardFaq> faqList = fService.selectAll();
        
        // 2. Model 객체에 조회된 목록을 담아 JSP로 전달
        model.addAttribute("faqList", faqList);
        
        // 3. faq.jsp 페이지로 포워딩
        return "board/faq"; // JSP 파일 경로
    }
}

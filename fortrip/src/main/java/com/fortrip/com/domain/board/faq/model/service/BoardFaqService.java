package com.fortrip.com.domain.board.faq.model.service;

import java.util.List;

import com.fortrip.com.domain.board.faq.model.vo.BoardFaq;

public interface BoardFaqService {
	
	List<BoardFaq> selectAll();
}

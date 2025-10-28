package com.fortrip.com.domain.board.faq.model.service.Impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fortrip.com.domain.board.faq.model.mapper.BoardFaqMapper;
import com.fortrip.com.domain.board.faq.model.service.BoardFaqService;
import com.fortrip.com.domain.board.faq.model.vo.BoardFaq;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardFaqServiceImpl implements BoardFaqService{

	private final BoardFaqMapper fMapper;
	
	@Override
	public List<BoardFaq> selectAll() {
		return fMapper.selectAll(); // Mapper 호출
	}
}

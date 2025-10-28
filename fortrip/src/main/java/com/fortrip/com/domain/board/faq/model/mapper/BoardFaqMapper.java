package com.fortrip.com.domain.board.faq.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.domain.board.faq.model.vo.BoardFaq;

@Mapper
public interface BoardFaqMapper {

	BoardFaq selectOneByNo(int faqNo);
	List<BoardFaq> selectAll();
}

package com.fortrip.com.domain.admin.question.model.service.Impl;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.question.model.mapper.QuestionMapper;
import com.fortrip.com.domain.admin.question.model.service.QuestionService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QuestionServiceImpl implements QuestionService{
	
	private final QuestionMapper qMapper;

	@Override
	public int questionInsert(QuestionDTO question) {
		// TODO Auto-generated method stub
		int result = qMapper.questionInsert(question);
		return result;
	}
	
}

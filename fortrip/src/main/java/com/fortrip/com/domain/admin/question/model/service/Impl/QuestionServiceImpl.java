package com.fortrip.com.domain.admin.question.model.service.Impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.question.model.mapper.QuestionMapper;
import com.fortrip.com.domain.admin.question.model.service.QuestionService;
import com.fortrip.com.domain.admin.question.model.vo.QuestionVO;

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

	@Override
	public List<QuestionVO> AllquestionList() {
		// TODO Auto-generated method stub
		List<QuestionVO> qList = qMapper.AllquestionList();
		return qList;
	}

	@Override
	public int questionDelete(int questionNo) {
		// TODO Auto-generated method stub
		int result = qMapper.questionDelete(questionNo);
		return result;
	}
	
}

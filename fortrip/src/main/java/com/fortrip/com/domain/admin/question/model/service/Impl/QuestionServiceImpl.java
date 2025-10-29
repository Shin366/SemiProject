package com.fortrip.com.domain.admin.question.model.service.Impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;
import com.fortrip.com.domain.admin.question.model.mapper.QuestionMapper;
import com.fortrip.com.domain.admin.question.model.service.QuestionService;
import com.fortrip.com.domain.admin.question.model.vo.QuestionVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QuestionServiceImpl implements QuestionService{
	
	private final QuestionMapper qMapper;

	// 자주하는 질문 삽입
	@Override
	public int questionInsert(QuestionDTO question) {
		int result = qMapper.questionInsert(question);
		return result;
	}
	// 자주하는 질문 총 갯수 
	@Override
	public int getQuestionTotalCount() {
		int getTotalCount = qMapper.getQuestionTotalCount();
		return getTotalCount;
	}
	
	// 자주하는 질문 카테고리 리스트
	@Override
	public List<QuestionVO> getQuestionList(String category) {
		// TODO Auto-generated method stub
		List<QuestionVO> qList = qMapper.getQuestionList(category);
		return qList;
	}
	@Override
	public int questionDelete(int questionNo) {
		// TODO Auto-generated method stub
		int result = qMapper.questionDelete(questionNo);
		return result;
	}
	@Override
	public QuestionVO selectQuestionNo(int questionNo) {
		// TODO Auto-generated method stub
		QuestionVO question = qMapper.selectQuestionNo(questionNo);
		return question;
	}

	
}

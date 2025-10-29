package com.fortrip.com.domain.admin.question.model.service;

import java.util.List;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.qna.model.vo.QnAVO;
import com.fortrip.com.domain.admin.question.model.vo.QuestionVO;

public interface QuestionService {
	/* 자주하는 질문 삽입 */
	int questionInsert(QuestionDTO question);
	/* 자주하는 질문 카테고리 */
	List<QuestionVO> getQuestionList(String category);
	/* 자주하는 질문 게시판 총 갯수 */
	int questionDelete(int questionNo);
	
	int getQuestionTotalCount();
	
	QuestionVO selectQuestionNo(int questionNo);

}

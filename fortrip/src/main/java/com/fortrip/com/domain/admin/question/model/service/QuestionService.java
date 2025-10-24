package com.fortrip.com.domain.admin.question.model.service;

import java.util.List;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.qna.model.vo.QnAVO;
import com.fortrip.com.domain.admin.question.model.vo.QuestionVO;

public interface QuestionService {
	int questionInsert(QuestionDTO question);

	List<QuestionVO> AllquestionList();

	int questionDelete(int questionNo);
}

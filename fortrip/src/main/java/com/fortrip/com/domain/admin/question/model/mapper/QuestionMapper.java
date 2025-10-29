package com.fortrip.com.domain.admin.question.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.question.model.vo.QuestionVO;

@Mapper
public interface QuestionMapper {
	/* 자주하는 질문 삽입 */
	int questionInsert(QuestionDTO question);
	/* 자주하는 질문 총 갯수 */
	int getQuestionTotalCount();
	/* 자주하는 질문 리스트 */
	List<QuestionVO> getQuestionList(String category);
	int questionDelete(int questionNo);
	QuestionVO selectQuestionNo(int questionNo);




}

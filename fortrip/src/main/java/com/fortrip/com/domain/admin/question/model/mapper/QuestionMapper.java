package com.fortrip.com.domain.admin.question.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;
import com.fortrip.com.domain.admin.question.model.vo.QuestionVO;

@Mapper
public interface QuestionMapper {

	int questionInsert(QuestionDTO question);

	List<QuestionVO> AllquestionList();

	int questionDelete(int questionNo);
}

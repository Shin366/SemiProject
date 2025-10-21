package com.fortrip.com.domain.admin.question.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.admin.question.dto.QuestionDTO;

@Mapper
public interface QuestionMapper {

	int questionInsert(QuestionDTO question);

}

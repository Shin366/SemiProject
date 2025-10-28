package com.fortrip.com.domain.admin.qna.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.domain.admin.qna.model.vo.QnAVO;

@Mapper
public interface QnAMapper {

	List<QnAVO> AllqnaList();

}

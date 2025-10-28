package com.fortrip.com.domain.admin.qna.model.service.Impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fortrip.com.domain.admin.qna.model.mapper.QnAMapper;
import com.fortrip.com.domain.admin.qna.model.service.QnAService;
import com.fortrip.com.domain.admin.qna.model.vo.QnAVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QnAServiceImpl implements QnAService{
	private final QnAMapper qnaMapper;
	@Override
	public List<QnAVO> AllqnaList() {
		// TODO Auto-generated method stub
		List<QnAVO> qList = qnaMapper.AllqnaList();
		System.out.println(qList);
		return qList;
	}

}

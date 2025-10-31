package com.fortrip.com.domain.member.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.member.dto.MyBoard;
import com.fortrip.com.domain.member.model.mapper.MyPageMapper;
import com.fortrip.com.domain.member.model.service.MyPageService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService{
	
	private final MyPageMapper pMapper;
	
	@Override
	public List<MyBoard> getMyCommunityList(int memberNo) {
		List<MyBoard> result = pMapper.selectMyCommunityList(memberNo);
		return result;
	}

	@Override
	public List<MyBoard> getMyReviewList(int memberNo) {
		List<MyBoard> result = pMapper.selectMyReviewList(memberNo);
		return result;
	}

	@Override
	public List<MyBoard> getMyAllBoardList(int memberNo) {
		List<MyBoard> result = pMapper.getMyAllBoardList(memberNo);
		return result;
	}

}

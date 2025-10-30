package com.fortrip.com.domain.member.model.service;

import java.util.List;

import com.fortrip.com.app.member.dto.MyBoard;

public interface MyPageService {

	List<MyBoard> getMyCommunityList(int memberNo);

	List<MyBoard> getMyReviewList(int memberNo);

	List<MyBoard> getMyAllBoardList(int memberNo);
	
}

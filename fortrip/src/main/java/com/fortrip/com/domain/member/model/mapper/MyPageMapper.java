package com.fortrip.com.domain.member.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.member.dto.MyBoard;

@Mapper
public interface MyPageMapper {

	List<MyBoard> selectMyCommunityList(int memberNo);

	List<MyBoard> selectMyReviewList(int memberNo);

	List<MyBoard> getMyAllBoardList(int memberNo);
	
}

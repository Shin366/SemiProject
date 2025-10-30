package com.fortrip.com.domain.board.review.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.domain.board.review.model.vo.ReviewTrip;

@Mapper
public interface ReviewTripMapper {
	List<ReviewTrip> selectAllRoadList();

}

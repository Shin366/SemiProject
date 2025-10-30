package com.fortrip.com.domain.board.review.model.sevice.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fortrip.com.domain.board.review.model.mapper.ReviewTripMapper;
import com.fortrip.com.domain.board.review.model.sevice.ReviewTripService;
import com.fortrip.com.domain.board.review.model.vo.ReviewTrip;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class ReviewTripServiceImpl implements ReviewTripService{
	
	private final ReviewTripMapper mapper;

	@Override
	public List<ReviewTrip> findAllRoads() {
		return mapper.selectAllRoadList();
    }

}

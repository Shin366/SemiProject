package com.fortrip.com.app.board.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fortrip.com.domain.board.review.model.sevice.ReviewTripService;
import com.fortrip.com.domain.board.review.model.vo.ReviewTrip;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/review/trip")
@RequiredArgsConstructor
public class ReviewTripController {

    private final ReviewTripService roadService; // 또는 TripService 재사용

    @GetMapping("/list")
    public List<Map<String, Object>> getRoadList(HttpSession session) {
        // 로그인한 사용자 확인 (선택)
        Member loginUser = (Member) session.getAttribute("loginUser");

        // 전체 목록 or 사용자 맞춤 목록
        List<ReviewTrip> list = roadService.findAllRoads();

        // JS에서 사용하는 형식으로 변환 [{roadNo, roadName}]
        return list.stream()
        	    .map(r -> {
        	        Map<String, Object> map = new HashMap<>();
        	        map.put("roadNo", r.getRoadNo());
        	        map.put("roadName", r.getRoadName());
        	        return map;
        	    })
        	    .collect(Collectors.toList());
    }
}


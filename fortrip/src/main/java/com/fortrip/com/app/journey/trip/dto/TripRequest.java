package com.fortrip.com.app.journey.trip.dto;

import lombok.Getter;
import lombok.Setter;

@Getter 
@Setter
public class TripRequest {
    private String destination; // ROAD_NAME/ROAD_LOCATION LIKE
    private int page = 1;       // 1-base
    private int size = 8;       // 4x2 카드
}
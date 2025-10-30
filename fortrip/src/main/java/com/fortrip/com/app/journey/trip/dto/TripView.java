package com.fortrip.com.app.journey.trip.dto;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import lombok.Builder;
import lombok.Getter;

@Getter
public class TripView {
    private final int id;
    private final String title;
    private final String location;
    private final String thumbnailUrl; // 컬럼 생기면 매핑
    private final Timestamp createdAt;

    private final String intro;
    private final String start;
    private final String end;
    private final String cost;
    private final String roadStyle;
    private final String slogan;
    private final String itineraryJson;
    
    private final Integer memberNo;
    
    private final java.util.List<String> routeList;
    
    @Builder
    public TripView(int id, String title, String location,
            String thumbnailUrl, java.sql.Timestamp createdAt,
            String intro, String start, String end, String cost,
            String roadStyle, String slogan, String itineraryJson,
            Integer memberNo,
            String routeCsv) {
    	this.id = id;
        this.title = title;
        this.location = location;
        this.thumbnailUrl = thumbnailUrl;
        this.createdAt = createdAt;

        this.intro = intro;
        this.start = start;
        this.end = end;
        this.cost = cost;
        this.roadStyle = roadStyle;
        this.slogan = slogan;
        this.itineraryJson = itineraryJson;
        this.memberNo = memberNo;
        this.routeList = (routeCsv == null || routeCsv.isBlank())
                ? List.of()
                : Arrays.asList(routeCsv.split("\\s*,\\s*"));
    }
    
    public String getRoute() { // title에 바로 쓰고 싶으면
        return (routeList == null || routeList.isEmpty()) ? "" : String.join(", ", routeList);
    }
//    public String[] getRouteArray() { // fn:join 사용할 때
//        return (routeList == null) ? new String[0] : routeList.toArray(new String[0]);
//    }

}
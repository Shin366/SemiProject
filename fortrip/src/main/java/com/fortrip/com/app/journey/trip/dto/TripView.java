package com.fortrip.com.app.journey.trip.dto;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

import com.fortrip.com.domain.journey.trip.model.vo.Trip;

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
    
    private final java.util.List<String> routeList;
    
    @Builder
    public TripView(int id, String title, String location,
            String thumbnailUrl, java.sql.Timestamp createdAt,
            String intro, String start, String end, String cost,
            String roadStyle, String slogan, String itineraryJson,
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
    private TripView toView(Trip r) {
        return TripView.builder()
            .id(r.getRoadNo())
            .title(r.getRoadName())
            .location(r.getRoadLocation())
            .thumbnailUrl(r.getThumbUrl())   // ✅ null 고정 제거
            .createdAt(r.getWriteDate())

            // ✅ 상세에서 쓰는 것들 매핑
            .intro(r.getRoadIntro())
            .start(r.getRoadStart())
            .end(r.getRoadEnd())
            .cost(r.getRoadCost())
            .roadStyle(r.getRoadStyle())
            .slogan(r.getSlogan())
            .itineraryJson(r.getItineraryJson())

            // ROUTE_CSV 컬럼이 없으니 빈 값 유지
            .routeCsv(null)
            .build();
    }

}
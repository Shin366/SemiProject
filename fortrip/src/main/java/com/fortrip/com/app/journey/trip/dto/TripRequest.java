package com.fortrip.com.app.journey.trip.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class TripRequest {
	private Long id;
    private String title;
    private String route;          // "경복궁, 북촌한옥마을, 인사동"
    private String thumbnailUrl;
    private java.util.Date createdAt;

    // 화면용(편의): routeList (DB필드 아님)
    private java.util.List<String> routeList;
}

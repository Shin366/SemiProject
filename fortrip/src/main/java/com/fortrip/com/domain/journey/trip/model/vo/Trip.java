package com.fortrip.com.domain.journey.trip.model.vo;



import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Trip {

	private int roadNo;          // ROAD_NO
    private String roadName;      // ROAD_NAME
    private String roadStart;     // ROAD_START
    private String roadEnd;       // ROAD_END
    private String roadLocation;  // ROAD_LOCATION
    private String roadYn;        // ROAD_YN (Y/N)
    private String roadCost;      // ROAD_COST
    private String roadStyle;     // ROAD_STYLE
    private String roadIntro;     // ROAD_INTRO
    private String deleteYn;      // DELETE_YN
    private Timestamp writeDate;  // WRITE_DATE
    private String type;          // TYPE ('ROAD' or 'TRAVEL')

    // ===== 화면용 추가 필드 (DB X) =====
    private String thumbnailUrl;  // 썸네일 이미지 URL (JSP img용)
    private String[] routeList;   // 경로 분리 표시 (ex. START~END 기준)
}

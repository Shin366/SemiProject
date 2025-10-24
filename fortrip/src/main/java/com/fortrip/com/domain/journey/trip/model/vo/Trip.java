package com.fortrip.com.domain.journey.trip.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/** ROAD 테이블과 1:1 매핑 */
@Getter @Setter @ToString @NoArgsConstructor
public class Trip {
    private int roadNo;            // NUMBER PK
    private String roadName;       // VARCHAR2(200)
    private String roadStart;      // VARCHAR2(80)
    private String roadEnd;        // VARCHAR2(80)
    private String roadLocation;   // VARCHAR2(40)
    private String roadYn;         // VARCHAR2(1)
    private String roadCost;       // VARCHAR2(100)
    private String roadStyle;      // VARCHAR2(30)
    private String roadIntro;      // VARCHAR2(2000)
    private String deleteYn;       // VARCHAR2(1)
    private Timestamp writeDate;   // TIMESTAMP
    private String type;           // 'ROAD','TRAVEL'
    private String memberId;       // VARCHAR2(50)
}


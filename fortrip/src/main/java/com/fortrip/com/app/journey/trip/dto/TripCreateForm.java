package com.fortrip.com.app.journey.trip.dto;

import java.time.LocalDate;
import java.util.List;

import com.fortrip.com.domain.journey.trip.model.vo.Trip;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter 
@ToString
public class TripCreateForm {

    // tripAdd.jsp name들과 동일해야 함
    private String title;                  // 플랜의 제목
    private LocalDate startDate;           // 시작일
    private LocalDate endDate;             // 종료일
    private String region;                 // 지역 (서울/부산 등)
    private Integer budget;                // 총계 예산
    private String budgetUnit;             // 원 / USD
    private List<String> themes;           // 체크박스 name="themes"
    private String description;            // 코스소개
    private String slogan;                 // 핵심 문구
    private String itineraryJson;          // 숨은필드 (일정 JSON)
    private String routeCsv;

    // JSP -> DB(VO) 변환
    public Trip toTripVo() {
        Trip t = new Trip();
        t.setRoadName(title);
        t.setRoadStart(startDate != null ? startDate.toString() : null);
        t.setRoadEnd(endDate   != null ? endDate.toString()   : null);
        t.setRoadLocation(region);

        // 전시 여부(Y/N). 등록은 무조건 Y로 올린다던지, 운영정책에 맞춰 세팅
        t.setRoadYn("Y");

        // 예산 + 단위를 문자열로 보관 (칼럼이 문자열이라 우선 이렇게 매핑)
        // ex) "400000 원"
        if (budget != null && budgetUnit != null) {
            t.setRoadCost(budget + " " + budgetUnit);
        }

        // 스타일(테마들) CSV로 저장
        // ex) "먹방코스,바다/섬"
        if (themes != null && !themes.isEmpty()) {
            t.setRoadStyle(String.join(",", themes));
        }

        // 소개문(설명) 저장
        t.setRoadIntro(description);
        
        t.setSlogan(slogan);
        
        t.setItineraryJson(itineraryJson);

        t.setRoadYn("Y");
        // 나머지는 Service/Mapper에서 처리
        return t;
    }
}
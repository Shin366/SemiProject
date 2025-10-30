package com.fortrip.com.app.journey.trip.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class TripUpdateForm {
    private int id;             // ROAD_NO
    private String title;
    private String region;
    private String startDate;
    private String endDate;
    private Integer budget;
    private String budgetUnit;
    private String[] themes;
    private String description;
}
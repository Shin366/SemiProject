package com.fortrip.com.domain.board.review.model.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class ReviewTrip {
	 private int roadNo; 
	 @JsonProperty("roadName")// NUMBER PK
	 private String roadName;       // VARCHAR2(200)
	 
	 public void setRoadNo(int roadNo) {
	        this.roadNo = roadNo;
	    }

	    public void setRoadName(String roadName) {
	        this.roadName = roadName;
	    }

}

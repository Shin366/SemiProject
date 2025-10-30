package com.fortrip.com.domain.member.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CourseViewHistory {
	private Long historyNo;
	private Long memberNo;
	private Long courseId;
	private String courseType;
	private Timestamp viewDate;
	
	//join
	private String roadName;
	private String roadLocation;
	
	
}

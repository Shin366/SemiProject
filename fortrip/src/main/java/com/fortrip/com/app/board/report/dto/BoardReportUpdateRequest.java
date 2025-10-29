package com.fortrip.com.app.board.report.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardReportUpdateRequest {
	private int reportNo;
	private int memberNo;
	private String reportTitle;
	private String reportContent;
	private Timestamp updateDate;
}

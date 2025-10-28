package com.fortrip.com.domain.board.report.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardReportVO {
	private int reportNo;
    private int memberNo;
    private String reportTitle;
    private String reportContent;
    private String reportWriter; // JOIN된 닉네임
    private String reportReason;
    private String reportPassword; 
    private Timestamp writeDate;
    private Timestamp updateDate;
    private String deleteYn;
    private int commentCount;
}

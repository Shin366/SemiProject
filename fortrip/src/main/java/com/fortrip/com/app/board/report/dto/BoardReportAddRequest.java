package com.fortrip.com.app.board.report.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardReportAddRequest {
	private int reportNo;
	private int memberNo;
	private String reportTitle;
	
	// JSP 폼에서 받아올 필드
    private String reportReason;    // 신고 사유 (radio 버튼 값)
    private String reportContent;   // 상세 내용 (textarea)
    private String reportPassword;  // 열람용 비밀번호 (input type="password")
}

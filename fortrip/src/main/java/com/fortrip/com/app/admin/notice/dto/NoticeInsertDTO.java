package com.fortrip.com.app.admin.notice.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class NoticeInsertDTO {
	private String noticeTitle;
	private String noticeContent;
	private String noticeWriter;
}

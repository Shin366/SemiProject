package com.fortrip.com.domain.admin.notice.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class NoticeVO {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private String noticeWriter;
	private Timestamp writeDate;
	private int viewCount;
	private String attachmentName;
	private String attachmentPath;
	private Timestamp attachmentDate;
}

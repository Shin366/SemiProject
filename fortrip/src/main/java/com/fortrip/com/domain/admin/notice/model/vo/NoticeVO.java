package com.fortrip.com.domain.admin.notice.model.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
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

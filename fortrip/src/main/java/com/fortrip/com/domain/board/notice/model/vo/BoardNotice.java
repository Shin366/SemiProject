package com.fortrip.com.domain.board.notice.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Getter
@ToString 
@AllArgsConstructor
@NoArgsConstructor
public class BoardNotice {
	    private int noticeNo;
	    private int memberNo;
	    private String noticeTitle;
	    private String noticeContent;
	    private String writerName;
	    private String writerId;
	    private Timestamp writerDate;
	    private int viewCount;
	    private String attachmentName;
	    private String attachmentPath;
	    private String deleteYn;
}

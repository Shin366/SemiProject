package com.fortrip.com.app.board.free.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardFreeUpdateRequest {
	private int postNo;
	private int memberNo;
	private String postTitle;
	private String postContent;
	private Timestamp updateDate;
}

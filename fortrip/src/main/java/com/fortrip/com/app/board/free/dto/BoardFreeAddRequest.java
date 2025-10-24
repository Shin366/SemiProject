package com.fortrip.com.app.board.free.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardFreeAddRequest {
	private int postNo;
	private String postTitle;
	private String postContent;
	private String postWriter;
	private int memberNo;
	private int nickName;
}

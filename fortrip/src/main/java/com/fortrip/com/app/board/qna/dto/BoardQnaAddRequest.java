package com.fortrip.com.app.board.qna.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardQnaAddRequest {
	private int qnaNo;
	private int memberNo;
	private String qnaTitle;
	private String qnaContent;

}

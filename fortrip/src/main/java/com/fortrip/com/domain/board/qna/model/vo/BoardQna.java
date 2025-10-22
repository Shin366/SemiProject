package com.fortrip.com.domain.board.qna.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardQna {
	private int qnaNo;
	private int memberNo;
	private String qnaTitle;
	private String qnaContent;
	private String qnaPassword;
	private String isPrivate;
	private Timestamp writeDate;
	private Timestamp updateDate;
	private int viewCount;
	private String deleteYn;
}

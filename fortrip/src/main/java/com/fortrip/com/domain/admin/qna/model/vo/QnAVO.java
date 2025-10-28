package com.fortrip.com.domain.admin.qna.model.vo;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class QnAVO {
	private int qnaNo;
	private int memberNo;
	private String qnaTitle;
	private String qnaContent;
	private int viewCount;
	private int qnaPw;
	private String isPrivate;
	private Date writeDate;
	private Date updateDate;
	private String deleteYn;
}

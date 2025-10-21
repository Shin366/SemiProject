package com.fortrip.com.domain.admin.question.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class QuestionVO {
	private int questionNo;
	private String questionTitle;
	private String questionCategory;
	private String questionContent;
}

package com.fortrip.com.app.admin.question.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class QuestionDTO {
	private int questionNo;
	private String questionTitle;
	private String questionCategory;
	private String questionContent;
}

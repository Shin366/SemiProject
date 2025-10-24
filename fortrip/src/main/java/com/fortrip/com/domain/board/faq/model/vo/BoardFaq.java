package com.fortrip.com.domain.board.faq.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardFaq {
	private int questionNo; 				// 자주묻는질문 고유번호
	private String questionCategory; 	// 자주묻는질문 카테고리
	private String questionTitle; 		// 자주묻는질문 제목
	private String questionContent; 		// 자주묻는질문 답변내용
	private String deleteYn;		// 삭제 여부
}

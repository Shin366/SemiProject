package com.fortrip.com.domain.board.like.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor 
@AllArgsConstructor
public class BoardLikeVO {
	
	private int likeNo;       // 좋아요 번호 (PK) - LIKE_NO
    private String boardType;   // 게시판 타입 - BOARD_TYPE
    private int boardNo;        // 게시글 번호 - BOARD_NO
    private int memberNo;       // 회원 번호 (FK) - MEMBER_NO
    private Timestamp likeDate;   // 좋아요 누른 날짜 - LIKE_DATE

}

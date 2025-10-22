package com.fortrip.com.domain.board.free.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardFree {
	// 자유게시판 - 소통
	private int postNo;			// 게시글 고유 번호
	private int memberNo; 		// 게시글 작성 회원
	private String postTitle;	// 게시글 제목
	private String postContent;	// 게시글 내용
	private String postWriter;	// 게시글 작성자(회원 닉네임 연결)
	private int viewCount;		// 조회수
	private Timestamp writeDate;		// 작성일
	private Timestamp updateDate;	// 수정일
	private String isDelete;	// 삭제여부(논리삭제)
}

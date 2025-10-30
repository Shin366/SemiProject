package com.fortrip.com.domain.board.bookmark.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BookmarkVO {
	private int bookmarkNo;
	private int memberNo;
	private String targetType;
	private int targetNo;
	private Timestamp bookmarkDate;
	private String title;       // 게시글 제목
	private Timestamp writeDate; // 작성일
	private String thumbnailPath;   // 썸네일 경로 추가
}

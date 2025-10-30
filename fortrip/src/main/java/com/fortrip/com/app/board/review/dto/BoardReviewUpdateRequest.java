package com.fortrip.com.app.board.review.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardReviewUpdateRequest {
	private int reviewNo;
    private int memberNo;
    private int roadNo;             // 리뷰 대상 로드 번호 (hidden input 등으로 전달)
    private String reviewerType;    // 리뷰 작성자 타입 ('USER' 또는 'ADMIN') - (hidden input 또는 로직으로 설정)
    private String reviewTitle;     // 리뷰 제목
    private String reviewSubtitle;  // 리뷰 부제목
    private String reviewContent;   // 리뷰 내용
    private int reviewRating;       // 별점 (1~5)
    private String thumbnailPath;

}

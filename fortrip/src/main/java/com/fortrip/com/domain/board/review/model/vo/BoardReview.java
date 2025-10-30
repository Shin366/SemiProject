package com.fortrip.com.domain.board.review.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardReview {
	private int reviewNo;
    private int memberNo;
    private int roadNo;
    private String reviewerType; 
    private String reviewTitle;
    private String reviewSubtitle;
    private String reviewContent;
    private int reviewRating;     
    private int viewCount;
    private Timestamp writeDate;  
    private Timestamp updateDate; 
    private String deleteYn;
    private String thumbnailPath; //썸네일 이미지 추가

    // Join
    private String writer;        
    private int likeCount;
    private int bookmarkCount;
    private int commentCount;

}

package com.fortrip.com.app.member.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MyBoard {
    private int boardNo;             // 게시글 번호 (POST_NO / REVIEW_NO)
    private String boardType;        // 게시판 구분: "community" or "review"
    private String title;            // 제목 (POST_TITLE / REVIEW_TITLE)
    private String content;          // 내용 (POST_CONTENT / REVIEW_CONTENT)
    private int memberNo;            // 작성자 번호 (MEMBER_NO)
    private String memberId;         // 작성자 아이디 (MEMBER_ID)
    private String nickName;         // 작성자 닉네임 (NICKNAME)
    private int viewCount;           // 조회수 (VIEW_COUNT)
    private int bookmarkCount;       // 찜수 or 좋아요 수 (현재 0으로 고정)
    private int commentCount;        // 댓글 수 (현재 0으로 고정)
    private Date writeDate;          // 작성일 (WRITE_DATE)
    private String category;         // 카테고리 (REVIEWER_TYPE - 리뷰만)
    private String courseName;       // 코스 번호 (ROAD_NO - 리뷰만)
}
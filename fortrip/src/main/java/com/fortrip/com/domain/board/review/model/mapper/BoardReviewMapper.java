package com.fortrip.com.domain.board.review.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.board.review.dto.BoardReviewAddRequest;
import com.fortrip.com.domain.board.review.model.vo.BoardReview;

@Mapper
public interface BoardReviewMapper {

	int getTotalCount();

	List<BoardReview> selectReviewList(int offset, int reviewCountPerPage);

	int increaseViewCount(int reviewNo); // 조회수 증가

	BoardReview selectOneByNo(int reviewNo);

	int insertReview(BoardReviewAddRequest review); // 게시글 작성

}

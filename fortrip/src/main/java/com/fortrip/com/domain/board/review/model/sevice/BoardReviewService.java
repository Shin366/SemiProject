package com.fortrip.com.domain.board.review.model.sevice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.review.dto.BoardReviewAddRequest;
import com.fortrip.com.domain.board.review.model.vo.BoardReview;
import com.fortrip.com.domain.member.model.vo.Member;

public interface BoardReviewService {

	int getTotalCount();

	List<BoardReview> selectReviewList(int currentPage, int reviewCountPerPage);

	BoardReview selectOneByNo(int reviewNo);

	int insertReview(BoardReviewAddRequest review, List<MultipartFile> files, Member loginMember);

}

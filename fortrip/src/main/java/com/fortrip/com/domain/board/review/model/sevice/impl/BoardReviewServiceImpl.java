package com.fortrip.com.domain.board.review.model.sevice.impl;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.review.dto.BoardReviewAddRequest;
import com.fortrip.com.domain.attachment.service.AttachmentService;
import com.fortrip.com.domain.board.review.model.mapper.BoardReviewMapper;
import com.fortrip.com.domain.board.review.model.sevice.BoardReviewService;
import com.fortrip.com.domain.board.review.model.vo.BoardReview;
import com.fortrip.com.domain.member.model.vo.Member; // 경로 확인

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j; 

@Slf4j 
@Service
@RequiredArgsConstructor
public class BoardReviewServiceImpl implements BoardReviewService { 

	private final BoardReviewMapper reviewMapper;
	private final AttachmentService attachmentService;

	private static final String BOARD_TYPE = "REVIEW"; 

	@Override
	public int getTotalCount() { // 리뷰 게시글 전체 수 조회
		return reviewMapper.getTotalCount();
	}

	@Override
	public List<BoardReview> selectReviewList(int currentPage, int reviewCountPerPage) { // 리뷰 목록 조회 (페이징)
		int offset = (currentPage - 1) * reviewCountPerPage;
		// Mapper 인터페이스와 파라미터 개수/이름 일치 확인 필요
		return reviewMapper.selectReviewList(offset, reviewCountPerPage);
	}

	@Override
	@Transactional 
	public BoardReview selectOneByNo(int reviewNo) { // 리뷰 게시글 상세 조회 (+ 조회수 증가)
		// 1. 조회수 증가 시도
		int updateResult = reviewMapper.increaseViewCount(reviewNo);

		// 2. 조회수 증가 결과 확인 (존재하지 않는 글일 수 있음)
		if (updateResult == 0) {
			log.warn("조회수 증가 실패: 리뷰 번호 {} 없음", reviewNo);
			// 게시글이 실제로 없는지 한 번 더 확인 후 예외 발생 또는 null 반환 결정 가능
			// 여기서는 일단 조회를 시도하고 결과가 없으면 예외 발생시킴
		}

		// 3. 게시글 정보 조회 (증가된 조회수 포함)
		BoardReview review = reviewMapper.selectOneByNo(reviewNo);
		if (review == null) {
			 throw new IllegalArgumentException("존재하지 않는 리뷰 게시글입니다: " + reviewNo);
		}

		return review;
	}

	// 리뷰 게시판 작성
	@Override
	@Transactional(rollbackFor = Exception.class) 
	public int insertReview(BoardReviewAddRequest review, List<MultipartFile> files, Member loginMember) {

		// 1. DTO에 현재 로그인한 사용자 번호 설정
		review.setMemberNo(loginMember.getMemberNo());
		

		// ※ DTO에 roadNo, reviewerType, reviewSubtitle, reviewRating 값이 Controller에서 넘어왔다고 가정
		// 만약 Service에서 설정해야 한다면 여기서 로직 추가 필요

		// 2. 리뷰 게시글 DB에 저장
		int result = reviewMapper.insertReview(review);
		if (result == 0) {
            log.warn("리뷰 게시글 INSERT 실패: {}", review);
            return 0; // 실패 시 0 반환
        }

		int reviewNo = review.getReviewNo();

		// 4. 첨부 파일 저장 (공용 AttachmentService 사용)
		if (files != null && !files.isEmpty()) {
			try {
                log.info("리뷰 {}번 게시글 첨부파일 저장 시작...", reviewNo);
				attachmentService.saveFiles(files, BOARD_TYPE, reviewNo);
			} catch (IOException e) {
                log.error("리뷰 {}번 게시글 파일 저장 실패", reviewNo, e);
				// 파일 저장 실패 시 RuntimeException 발생 -> 트랜잭션 롤백
				throw new RuntimeException("리뷰 게시글 파일 저장 중 오류가 발생했습니다.", e);
			}
		}
		return result; // 성공 시 1 반환
	}

    // TODO: updateReview, deleteReview 메소드 구현 필요
    /*
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateReview(BoardReviewUpdateRequest reviewUpdateDto, List<MultipartFile> reloadFiles, List<Integer> deletedFiles, Member loginMember) {
        // 1. 수정 권한 확인 (원본 게시글 조회 후 작성자와 로그인 사용자 비교)
        // 2. 게시글 텍스트 업데이트 (Mapper.updateReview 호출)
        // 3. 삭제 파일 처리 (AttachmentService.deleteFilesByIds 호출)
        // 4. 새 파일 저장 (AttachmentService.saveFiles 호출)
        return 0; // 임시
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteReview(int reviewNo, Member loginMember) {
        // 1. 삭제 권한 확인 (원본 게시글 조회 후 작성자와 로그인 사용자 비교)
        // 2. 첨부파일 전체 삭제 (AttachmentService.deleteAttachmentsByBoard 호출)
        // 3. 게시글 논리 삭제 (Mapper.deleteReview 호출 - UPDATE DELETE_YN='Y')
        return 0; // 임시
    }
    */

}
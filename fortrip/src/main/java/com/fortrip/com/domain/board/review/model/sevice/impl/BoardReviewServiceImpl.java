package com.fortrip.com.domain.board.review.model.sevice.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.review.dto.BoardReviewAddRequest;
import com.fortrip.com.app.board.review.dto.BoardReviewUpdateRequest;
import com.fortrip.com.domain.attachment.service.AttachmentService;
import com.fortrip.com.domain.board.review.model.mapper.BoardReviewMapper;
import com.fortrip.com.domain.board.review.model.sevice.BoardReviewService;
import com.fortrip.com.domain.board.review.model.vo.BoardReview;
import com.fortrip.com.domain.image.model.mapper.ImageMapper;
import com.fortrip.com.domain.image.model.vo.Image;
import com.fortrip.com.domain.member.model.vo.Member; // 경로 확인

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j; 

@Slf4j 
@Service
@RequiredArgsConstructor
public class BoardReviewServiceImpl implements BoardReviewService { 

	private final BoardReviewMapper reviewMapper;
	private final AttachmentService attachmentService;
	private final ImageMapper imageMapper;
	
	@Value("${file.upload-path}")
	private String uploadPath;

	private static final String BOARD_TYPE = "REVIEW"; 

	@Override
	public int getTotalCount() { // 리뷰 게시글 전체 수 조회
		return reviewMapper.getTotalCount();
	}

	@Override
	public List<BoardReview> selectReviewList(int currentPage, int reviewCountPerPage) { // 리뷰 목록 조회 (페이징)
		int offset = (currentPage - 1) * reviewCountPerPage;
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
		

		// 2. 리뷰 게시글 DB에 저장
		int result = reviewMapper.insertReview(review);
		if (result == 0) {
            log.warn("리뷰 게시글 작성 실패: {}", review);
            return 0; // 실패 시 0 반환
        }

		int reviewNo = review.getReviewNo();

		// 3. 첨부 파일 저장 (공용 AttachmentService 사용)
		if (files != null && !files.isEmpty()) {
			try {
                log.info("리뷰 {}번 게시글 첨부파일 저장 시작...", reviewNo);
                
               for(int i = 0; i < files.size(); i++) {
            	   MultipartFile file = files.get(i);
            	   		if(!file.isEmpty()) {
            	   			String originalName = file.getOriginalFilename();
            	   			String savedName = UUID.randomUUID() + "_"+ originalName;
            	   			
            	   			//실제 서버 저장
            	   			File saveFile = new File(uploadPath, savedName);
            	   			file.transferTo(saveFile);
            	   			
            	   			//DB 저장
            	   			String imagePath = "/uploads/"+savedName;
            	   			Image image = new Image();
                            image.setBoardType("REVIEW");
                            image.setBoardNo(reviewNo);
                            image.setImagePath(imagePath);
                            image.setOriginalName(originalName);
                            image.setSavedName(savedName);
                            image.setIsThumbnail(i == 0 ? "Y" : "N"); // 첫 번째 이미지를 썸네일로 지정

                            imageMapper.insertImage(image);

                            // 첫 번째 이미지면 리뷰 테이블에도 썸네일 경로 업데이트
                            if (i == 0) {
                                reviewMapper.updateThumbnailPath(reviewNo, imagePath);
                                log.info("리뷰 {}번 썸네일 경로: {}", reviewNo, imagePath);
                            }
                        }
                    }

                } catch (IOException e) {
                    log.error("리뷰 {}번 게시글 이미지 저장 실패", reviewNo, e);
                    throw new RuntimeException("이미지 저장 중 오류 발생", e);
                }
            }
            return result;
        }
/*
                // 파일 저장 (AttachmentService 공용)
                List<String> savedPaths = attachmentService.saveFiles(files, BOARD_TYPE, reviewNo);

                // 첫번째 파일을 썸네일로 지정
                if (!savedPaths.isEmpty()) {
                    thumbnailPath = savedPaths.get(0);
                    reviewMapper.updateThumbnailPath(reviewNo, thumbnailPath);
                    log.info("썸네일 경로 저장 완료: {}", thumbnailPath);
                }

            } catch (IOException e) {
                log.error("리뷰 {}번 게시글 파일 저장 실패", reviewNo, e);
                throw new RuntimeException("리뷰 게시글 파일 저장 중 오류 발생", e);
            }
        }

		return result; // 성공 시 1 반환
	}
*/
	// 리뷰게시판 수정
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateReview(BoardReviewUpdateRequest reviewUpdateDto, List<MultipartFile> reloadFiles, List<Integer> deletedFiles, Member loginMember) {

    	// 게시글 정보 조회
    	BoardReview origin = reviewMapper.selectOneByNo(reviewUpdateDto.getReviewNo());
        if (origin == null) {
            throw new IllegalArgumentException("존재하지 않는 리뷰 게시글입니다.");
        }

        // 수정 권한 확인
        if (origin.getMemberNo() != loginMember.getMemberNo()) {
            throw new SecurityException("본인 게시글만 수정할 수 있습니다.");
        }

        // 게시글 내용 수정
        int result = reviewMapper.updateReview(reviewUpdateDto);
        if (result == 0) {
            throw new RuntimeException("리뷰 수정에 실패했습니다.");
        }

        // 삭제 요청된 첨부파일 삭제
        if (deletedFiles != null && !deletedFiles.isEmpty()) {
            attachmentService.deleteFilesByIds(deletedFiles);
        }

        // 새로운 첨부파일 추가
        String newThumbnailPath = null;
        if (reloadFiles != null && !reloadFiles.isEmpty()) {
            try {
                List<String> savedPaths = attachmentService.saveFiles(reloadFiles, BOARD_TYPE, reviewUpdateDto.getReviewNo());
                if (!savedPaths.isEmpty()) {
                    newThumbnailPath = savedPaths.get(0); // 첫 번째 파일을 썸네일로 지정
                }
            } catch (IOException e) {
                throw new RuntimeException("첨부파일 저장 중 오류 발생", e);
            }
        }

        // 썸네일 갱신 (파일이 새로 추가된 경우만)
        if (newThumbnailPath != null) {
            reviewMapper.updateThumbnailPath(reviewUpdateDto.getReviewNo(), newThumbnailPath);
        }

        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteReview(int reviewNo, Member loginMember) {
    	
    	// 원본 게시글 조회
        BoardReview origin = reviewMapper.selectOneByNo(reviewNo);
        if (origin == null) {
            throw new IllegalArgumentException("존재하지 않는 리뷰 게시글입니다.");
        }

        if (origin.getMemberNo() != loginMember.getMemberNo()) {
            throw new SecurityException("본인 게시글만 삭제할 수 있습니다.");
        }
        
        // 이미지 삭제
        imageMapper.deleteImageByBoard(BOARD_TYPE, reviewNo);

        attachmentService.deleteAttachmentsByBoard(BOARD_TYPE, reviewNo);

        int result = reviewMapper.deleteReview(reviewNo);
        if (result == 0) {
            throw new RuntimeException("게시글 삭제 실패");
        }

        return result;
    }

}
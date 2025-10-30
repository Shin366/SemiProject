package com.fortrip.com.domain.board.qna.model.service.Impl;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.qna.dto.BoardQnaAddRequest;
import com.fortrip.com.app.board.qna.dto.BoardQnaUpdateRequest;
import com.fortrip.com.domain.attachment.service.AttachmentService;
import com.fortrip.com.domain.board.qna.model.mapper.BoardQnaMapper;
import com.fortrip.com.domain.board.qna.model.service.BoardQnaService;
import com.fortrip.com.domain.board.qna.model.vo.BoardQna;
import com.fortrip.com.domain.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardQnaServiceImpl implements BoardQnaService{

	private final BoardQnaMapper qMapper; 
	private final AttachmentService attachmentService;
	// BoardType을 상수로 관리해 오타 방지
    private static final String BOARD_TYPE = "QNA";
	
	@Override
	public int getTotalCount() {
		int totalCount = qMapper.getTotalCount();
		return totalCount;
	}

	@Override
	public List<BoardQna> selectQnaList(int currentPage, int boardCountPerPage) {
		int offset = (currentPage-1)*boardCountPerPage;
		List<BoardQna> qList = qMapper.selectQnaList(offset, boardCountPerPage);
		
		return qList;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertQna(BoardQnaAddRequest qna, List<MultipartFile> files, Member loginMember) {
		
		if(loginMember == null) {
			throw new IllegalArgumentException("로그인 정보가 필요합니다.");
		}
		if (qna.getIsPrivate() == null || qna.getIsPrivate().isBlank()) {
		    qna.setIsPrivate("N"); // 기본 공개
		}
		
		qna.setMemberNo(loginMember.getMemberNo());
		
		// Qna 게시글 DB에 저장
		int result = qMapper.insertQna(qna);
		if(result == 0) return 0;
		
		// 저장된 qna 게시글의 qnaNo 가져오기
		int qnaNo = qna.getQnaNo();
		
		// 3단계: 파일이 존재하면 AttachmentService에 파일 저장을 위임
        if (files != null && !files.isEmpty()) {
            try {
                //'QNA_BOARD' 타입의 'qnaNo'번 글에 속한 파일들
                attachmentService.saveFiles(files, BOARD_TYPE, qnaNo);
            } catch (IOException e) {
                // 파일 저장 실패 시 RuntimeException을 발생시켜 트랜잭션 롤백
                throw new RuntimeException("Q&A 게시글 파일 저장에 실패했습니다.", e);
            }
        }
		return result;
	}

	@Override
	public BoardQna selectOneByNo(int qnaNo) {
		BoardQna boardQna = qMapper.selectOneByNo(qnaNo);
		return boardQna;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteQna(int qnaNo) {
		//첨부파일 삭제
		attachmentService.deleteAttachmentsByBoard(BOARD_TYPE, qnaNo);
		// 게시글 삭제
		int result = qMapper.deleteQna(qnaNo);
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateBoardQna(BoardQnaUpdateRequest qna, List<MultipartFile> reloadFiles, List<Integer> deletedFiles) {
		// 1. 게시글 텍스트 내용 수정
	    int result = qMapper.updateQna(qna);

	    // 2. 삭제하도록 선택된 기존 파일들 삭제
	    if (deletedFiles != null && !deletedFiles.isEmpty()) {
	        attachmentService.deleteFilesByIds(deletedFiles);
	    }

	    // 3. 새로 추가된 파일들 저장
	    if (reloadFiles != null && !reloadFiles.isEmpty()) {
	        try {
	            attachmentService.saveFiles(reloadFiles, BOARD_TYPE, qna.getQnaNo());
	        } catch (IOException e) {
	            throw new RuntimeException("문의게시글 수정 중 파일 저장에 실패했습니다.", e);
	        }
	    }
	    
	    return result;
	}
}

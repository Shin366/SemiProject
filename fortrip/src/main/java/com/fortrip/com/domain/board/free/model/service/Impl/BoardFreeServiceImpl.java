package com.fortrip.com.domain.board.free.model.service.Impl;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.free.dto.BoardFreeAddRequest;
import com.fortrip.com.app.board.free.dto.BoardFreeUpdateRequest;
import com.fortrip.com.domain.attachment.service.AttachmentService;
import com.fortrip.com.domain.board.free.model.mapper.BoardFreeMapper;
import com.fortrip.com.domain.board.free.model.service.BoardFreeService;
import com.fortrip.com.domain.board.free.model.vo.BoardFree;
import com.fortrip.com.domain.member.model.service.MemberService;
import com.fortrip.com.domain.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j 
@Service
@RequiredArgsConstructor
public class BoardFreeServiceImpl implements BoardFreeService {

    private final BoardFreeMapper fMapper;
    private final AttachmentService attachmentService;
    private final MemberService memberService; 

    private static final String BOARD_TYPE = "FREE";

    @Override
    @Transactional 
    public BoardFree selectOneByNo(int postNo) {
        // 1. 조회수 증가
        int updateResult = fMapper.increaseViewCount(postNo);
        if (updateResult == 0) {
            log.warn("조회수 증가 실패: 게시글 번호 {} 없음 또는 이미 삭제됨", postNo);
        }

        // 2. 게시글 정보 조회
        BoardFree free = fMapper.selectOneByNo(postNo);
        if (free == null) {
            throw new IllegalArgumentException("존재하지 않는 게시글입니다: " + postNo);
        }
        return free;
    }

    @Override
    @Transactional(rollbackFor = Exception.class) // DB 변경 작업이므로 롤백 설정
    public int insertFree(BoardFreeAddRequest free, List<MultipartFile> files, Member loginMember) {

        if (loginMember == null) {
            throw new IllegalArgumentException("회원 정보를 찾을 수 없습니다. ");
        }
        
        // DTO에 회원 번호 설정
        free.setMemberNo(loginMember.getMemberNo());

        // 게시글 DB INSERT
        int result = fMapper.insertFree(free);
        if (result == 0) {
             log.warn("자유게시판 INSERT 실패: {}", free);
             return 0; // 실패 시 0 반환
        }

        int postNo = free.getPostNo();

        // 첨부파일 저장
        if (files != null && !files.isEmpty()) {
            try {
                attachmentService.saveFiles(files, BOARD_TYPE, postNo);
            } catch (IOException e) {
                 log.error("자유게시판 {}번 글 파일 저장 실패", postNo, e);
                throw new RuntimeException("파일 저장 실패", e); 
            }
        }
        return result; // 성공 시 1 반환
    }

    @Override
    public int getTotalCount() {
        return fMapper.getTotalCount();
    }

    @Override
    public List<BoardFree> selectFreeList(int currentPage, int freeCountPerPage) {
        int offset = (currentPage - 1) * freeCountPerPage;
        return fMapper.selectFreeList(offset, freeCountPerPage);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateBoardFree(BoardFreeUpdateRequest freeUpdateDto, List<MultipartFile> reloadFiles,
                               List<Integer> deletedFiles, Member loginMember) {

        // 사용자 정보 조회 (권한 확인용)
        if (loginMember == null) {
            throw new IllegalArgumentException("수정 권한 확인 실패: 회원 정보를 찾을 수 없습니다. ");
        }

        // 수정 대상 게시글 정보 조회 (작성자 확인용) ---
        BoardFree originalPost = fMapper.selectOneByNo(freeUpdateDto.getPostNo());
        if (originalPost == null) {
            throw new IllegalArgumentException("수정하려는 게시글이 존재하지 않습니다: " + freeUpdateDto.getPostNo());
        }

        // 수정 권한 확인
        if (originalPost.getMemberNo() != loginMember.getMemberNo()) {
            log.warn("수정 권한 없음: 게시글 작성자={}, 요청자={}", originalPost.getMemberNo(), loginMember.getMemberNo());
            throw new SecurityException("게시글 수정 권한이 없습니다.");
        }

        // 게시글 텍스트 내용 수정
        int result = fMapper.updateFree(freeUpdateDto);
        if (result == 0) {
             log.warn("자유게시판 UPDATE 실패: {}", freeUpdateDto);
             return 0; 
        }

        // 삭제하도록 선택된 기존 파일들 삭제
        if (deletedFiles != null && !deletedFiles.isEmpty()) {
            try {
                 attachmentService.deleteFilesByIds(deletedFiles);
            } catch (Exception e) {
                 log.error("기존 첨부파일 삭제 중 오류 발생: {}", deletedFiles, e);
                 throw new RuntimeException("기존 첨부파일 삭제 중 오류가 발생했습니다.", e); 
            }
        }

        // 새로 추가된 파일들 저장
        if (reloadFiles != null && !reloadFiles.isEmpty()) {
            try {
                attachmentService.saveFiles(reloadFiles, BOARD_TYPE, freeUpdateDto.getPostNo());
            } catch (IOException e) {
                 log.error("새 첨부파일 저장 중 오류 발생: postNo={}", freeUpdateDto.getPostNo(), e);
                 // RuntimeException 발생 -> 트랜잭션 롤백
                throw new RuntimeException("자유 게시글 수정 중 파일 저장에 실패했습니다.", e);
            }
        }
        return result; // 성공 시 1 반환 (또는 업데이트된 행 수)
    }

    //조회수 증가
	@Override
	public void increaseViewCount(int postNo) {
		 fMapper.increaseViewCount(postNo);
		
	}

	@Override
	public int deleteFree(int postNo) {
		return fMapper.deleteFree(postNo);
	}
}
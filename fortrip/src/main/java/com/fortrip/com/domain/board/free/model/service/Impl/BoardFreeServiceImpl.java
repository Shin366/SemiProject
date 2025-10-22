package com.fortrip.com.domain.board.free.model.service.Impl;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.free.dto.BoardFreeAddRequest;
import com.fortrip.com.domain.board.free.model.mapper.BoardFreeMapper;
import com.fortrip.com.domain.board.free.model.service.BoardFreeService;
import com.fortrip.com.domain.board.free.model.vo.BoardFree;
import com.fortrip.com.domain.common.model.service.AttachmentService;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class BoardFreeServiceImpl implements BoardFreeService{

	private final BoardFreeMapper fMapper;
	private final AttachmentService attachmentService; // 공용 서비스를 주입받아 사용
	
	@Override
	public BoardFree selectOneByNo(int freeNo) {
		BoardFree free = fMapper.selectOneByNo(freeNo);
	    if (free == null) {
	        throw new IllegalArgumentException("존재하지 않는 게시글입니다.");
	    }
	    return free;
	}

	@Override
 	@Transactional
	public int insertFree(BoardFreeAddRequest free, List<MultipartFile> files) {
//		public int insertFree(FreeAddRequest free, List<MultipartFile> files, Member loginMember) {	// membervo 추가 후 주석해제
		/*
			1. DTO에 로그인한 사용자의 고유번호와 닉네임(작성자)을 직접 설정
	            -> 폼 데이터 조작을 통한 작성자 사칭 원천 차단
	        free.setMemberNo(loginMember.getMemberNo());
	        free.setPostWriter(loginMember.getNickname());
		 */
		
		
		// 2. 사용자 정보가 담긴 DTO를 Mapper로 전달하여 게시글 INSERT
		int result = fMapper.insertFree(free);
        if(result == 0) return 0;
       
        int postNo = free.getPostNo(); // Mapper에서 생성된 PK를 받아옴
        
        // 2. 파일 저장은 공용 서비스에 위임
        if (files != null && !files.isEmpty()) {
            try {
                // "이 파일들은 'FREE_BOARD' 타입의 'postNo'번 글에 속한 파일들이다"
                attachmentService.saveFiles(files, "FREE_BOARD", postNo);
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 실패", e); // 예외를 던져 롤백 처리
            }
        }
        
        return result;
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
}

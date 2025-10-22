package com.fortrip.com.domain.board.free.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.free.dto.BoardFreeAddRequest;
import com.fortrip.com.domain.board.free.model.vo.BoardFree;

public interface BoardFreeService {

	BoardFree selectOneByNo(int freeNo);

	int insertFree(BoardFreeAddRequest free, List<MultipartFile> files);
	// membervo 추가 후 주석 해제 - 로그인기능 있어야함
//	int insertFree(FreeAddRequest free, List<MultipartFile> files, Member loginMember);

	int getTotalCount();

	List<BoardFree> selectFreeList(int currentPage, int freeCountPerPage);

}

package com.fortrip.com.domain.board.free.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.free.dto.BoardFreeAddRequest;
import com.fortrip.com.app.board.free.dto.BoardFreeUpdateRequest;
import com.fortrip.com.domain.board.free.model.vo.BoardFree;
import com.fortrip.com.domain.member.model.vo.Member;

public interface BoardFreeService {

	BoardFree selectOneByNo(int postNo);

	int insertFree(BoardFreeAddRequest free, List<MultipartFile> files, Member loginMember);

	int getTotalCount();

	List<BoardFree> selectFreeList(int currentPage, int freeCountPerPage);

	int updateBoardFree(BoardFreeUpdateRequest free, List<MultipartFile> reloadFiles, List<Integer> deletedFiles, Member loginMember);

	void increaseViewCount(int postNo); // 조회수 증가

	int deleteFree(int postNo);

	List<BoardFree> searchFreeBoardList(Map<String, Object> searchMap);

	int getTotalCount(Map<String, Object> searchMap); // 검색어포함 전체 조회

	void insertSearchKeyword(String searchKeyword);

}

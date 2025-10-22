package com.fortrip.com.domain.board.qna.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.qna.dto.BoardQnaAddRequest;
import com.fortrip.com.app.board.qna.dto.BoardQnaUpdateRequest;
import com.fortrip.com.domain.board.qna.model.vo.BoardQna;

public interface BoardQnaService {

	int getTotalCount(); // 게시판 목록 조회용

	List<BoardQna> selectQnaList(int currentPage, int boardCountPerPage); // 목록조회 페이징

	int insertQna(BoardQnaAddRequest qna, List<MultipartFile> files); // 문의게시글 작성

	BoardQna selectOneByNo(int qnaNo); // 문의게시글 상세페이지

	int deleteQna(int qnaNo); // 문의게시글 삭제

	int updateBoardQna(BoardQnaUpdateRequest qna, List<MultipartFile> reloadFiles, List<Integer> deletedFiles);

}

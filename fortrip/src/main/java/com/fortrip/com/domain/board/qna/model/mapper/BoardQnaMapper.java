package com.fortrip.com.domain.board.qna.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fortrip.com.app.board.qna.dto.BoardQnaAddRequest;
import com.fortrip.com.app.board.qna.dto.BoardQnaUpdateRequest;
import com.fortrip.com.domain.board.qna.model.vo.BoardQna;

@Mapper
public interface BoardQnaMapper {

	int getTotalCount();

	List<BoardQna> selectQnaList(@Param("offset") int offset, @Param("boardCountPerPage") int boardCountPerPage);

	int insertQna(BoardQnaAddRequest qna); // 게시글 작성

	BoardQna selectOneByNo(int qnaNo); //게시글 상세페이지 조회

	int deleteQna(int qnaNo); // 문의 게시글 삭제

	int updateQna(BoardQnaUpdateRequest qna);

}

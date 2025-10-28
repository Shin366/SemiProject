package com.fortrip.com.domain.board.like.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fortrip.com.domain.board.like.model.vo.BoardLikeVO;

@Mapper
public interface BoardLikeMapper {

	/**
     * 특정 사용자가 특정 게시글에 좋아요를 눌렀는지 확인 (결과: 0 또는 1)
     * @param like boardType, boardNo, memberNo 가 설정된 BoardLike 객체
     * @return 좋아요 존재 시 1, 없으면 0
     */
    int checkLike(BoardLikeVO like);

    /**
     * 좋아요 정보 추가
     * @param like boardType, boardNo, memberNo 가 설정된 BoardLike 객체
     * @return INSERT 성공 시 1, 실패 시 0
     */
    int insertLike(BoardLikeVO like);

    /**
     * 좋아요 정보 삭제
     * @param like boardType, boardNo, memberNo 가 설정된 BoardLike 객체
     * @return DELETE 성공 시 1, 실패 시 0
     */
    int deleteLike(BoardLikeVO like);

    /**
     * 특정 게시글의 총 좋아요 수 조회
     * @param boardType 게시판 타입
     * @param boardNo 게시글 번호
     * @return 해당 게시글의 총 좋아요 수
     */
    int countLikesByBoard(@Param("boardType") String boardType, @Param("boardNo") int boardNo);

}

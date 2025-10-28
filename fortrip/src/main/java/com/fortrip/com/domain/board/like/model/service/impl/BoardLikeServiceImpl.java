package com.fortrip.com.domain.board.like.model.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fortrip.com.domain.board.like.model.mapper.BoardLikeMapper;
import com.fortrip.com.domain.board.like.model.service.BoardLikeService;
import com.fortrip.com.domain.board.like.model.vo.BoardLikeVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardLikeServiceImpl implements BoardLikeService{

	private final BoardLikeMapper boardLikeMapper;
	
	@Transactional
    public boolean toggleLike(String boardType, int boardNo, int memberNo) {
        BoardLikeVO like = new BoardLikeVO(0, boardType, boardNo, memberNo, null); // VO 생성자 확인 필요
        int count = boardLikeMapper.checkLike(like); // 1. 현재 상태 확인
        if (count > 0) {
        	boardLikeMapper.deleteLike(like); // 2. 있으면 삭제
            return false; // 좋아요 취소됨
        } else {
        	boardLikeMapper.insertLike(like); // 3. 없으면 추가
            return true; // 좋아요 처리됨
        }
    }

    public int getLikeCount(String boardType, int boardNo) {
        return boardLikeMapper.countLikesByBoard(boardType, boardNo);
    }

    public boolean checkIsLiked(String boardType, int boardNo, int memberNo) {
    	BoardLikeVO like = new BoardLikeVO(0, boardType, boardNo, memberNo, null);
         return boardLikeMapper.checkLike(like) > 0;
    }
	
}

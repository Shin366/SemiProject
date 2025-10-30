package com.fortrip.com.domain.board.like.model.service;

public interface BoardLikeService {

	boolean toggleLike(String boardType, int boardNo, int memberNo);

	int getLikeCount(String boardType, int boardNo);

	boolean checkIsLiked(String string, int boardNo, int memberNo);

}

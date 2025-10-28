package com.fortrip.com.domain.board.bookmark.model.service;

public interface BookmarkService {

	boolean toggleBookmark(int memberNo, String targetType, int targetNo);

	boolean isBookmarked(int memberNo, String targetType, int targetNo);


}

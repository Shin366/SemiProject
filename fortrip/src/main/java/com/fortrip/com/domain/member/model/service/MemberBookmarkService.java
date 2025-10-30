package com.fortrip.com.domain.member.model.service;

import java.util.List;
import java.util.Map;

import com.fortrip.com.domain.board.bookmark.model.vo.BookmarkVO;

public interface MemberBookmarkService {

	int countMyPosts(int memberNo);

	int countLikesOnMyPosts(int memberNo);

	int countMyBookmarks(int memberNo);

	List<Map<String, Object>> getBookmarksByMember(int memberNo);

	List<BookmarkVO> selectMyBookmarkList(int memberNo);

	
}

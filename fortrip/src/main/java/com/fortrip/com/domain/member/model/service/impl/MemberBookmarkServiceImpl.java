package com.fortrip.com.domain.member.model.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fortrip.com.domain.board.bookmark.model.vo.BookmarkVO;
import com.fortrip.com.domain.member.model.mapper.MemberBookmarkMapper;
import com.fortrip.com.domain.member.model.service.MemberBookmarkService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberBookmarkServiceImpl implements MemberBookmarkService{
	
	private final MemberBookmarkMapper bMapper;

	/**
	 * 내가 작성한 게시글 수
	 */
	@Override
	public int countMyPosts(int memberNo) {
		return bMapper.countMyPosts(memberNo);
	}

	/**
	 * 내가 작성한 게시글에 받은 좋아요 수
	 */
	@Override
	public int countLikesOnMyPosts(int memberNo) {
		return bMapper.countLikesOnMyPosts(memberNo);
	}

	/**
	 * 내가 저장한 북마크 수
	 */
	@Override
	public int countMyBookmarks(int memberNo) {
		return bMapper.countMyBookmarks(memberNo);
	}

	/**
	 * 내가 저장한 북마크 상세 목록 (JOIN 결과 - Map 형태)
	 */
	@Override
	public List<Map<String, Object>> getBookmarksByMember(int memberNo) {
		return bMapper.selectBookmarksByMember(memberNo);
	}

	@Override
	public List<BookmarkVO> selectMyBookmarkList(int memberNo) {
	    return bMapper.selectMyBookmarkList(memberNo);
	}
	
	
	
}

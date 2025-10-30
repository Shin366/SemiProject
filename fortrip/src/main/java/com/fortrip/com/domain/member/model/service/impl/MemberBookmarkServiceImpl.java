package com.fortrip.com.domain.member.model.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.member.dto.MyBoard;
import com.fortrip.com.domain.board.bookmark.model.vo.BookmarkVO;
import com.fortrip.com.domain.member.model.mapper.MemberBookmarkMapper;
import com.fortrip.com.domain.member.model.service.MemberBookmarkService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberBookmarkServiceImpl implements MemberBookmarkService{
	
	private final MemberBookmarkMapper bMapper;

	@Override
    public int countMyPosts(int memberNo) {
        return bMapper.countMyPosts(memberNo);
    }

    @Override
    public int countLikesOnMyPosts(int memberNo) {
        return bMapper.countLikesOnMyPosts(memberNo);
    }

    @Override
    public int countMyBookmarks(int memberNo) {
        return bMapper.countMyBookmarks(memberNo);
    }

    @Override
    public List<Map<String, Object>> getBookmarksByMember(int memberNo) {
        return bMapper.selectBookmarksByMember(memberNo);
    }

    @Override
    public List<BookmarkVO> selectMyBookmarkList(int memberNo) {
        return bMapper.selectMyBookmarkList(memberNo);
    }

	@Override
	public List<MyBoard> selectLikedBoards(int memberNo) {
		return bMapper.selectLikedBoards(memberNo);
	}

	@Override
	public void deleteSelectedBookmarks(int memberNo, List<Integer> ids) {
		bMapper.deleteSelectedBookmarks(memberNo, ids);
		
	}

	@Override
	public void deleteAllBookmarks(int memberNo) {
		bMapper.deleteAllBookmarks(memberNo);
		
	}
}

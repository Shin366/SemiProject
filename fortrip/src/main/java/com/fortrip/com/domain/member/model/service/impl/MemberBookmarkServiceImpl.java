package com.fortrip.com.domain.member.model.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fortrip.com.domain.board.bookmark.model.vo.BookmarkVO;
import com.fortrip.com.domain.member.model.mapper.MemberBookmarkMapper;
import com.fortrip.com.domain.member.model.service.MemberBookmarkService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberBookmarkServiceImpl implements MemberBookmarkService {
    
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
    public List<BookmarkVO> selectBookmarksByMember(int memberNo) {
        return bMapper.selectBookmarksByMember(memberNo);
    }
    
    @Override
    public void deleteSelectedBookmarks(int memberNo, List<Integer> ids) {
        Map<String, Object> param = new HashMap<>();
        param.put("memberNo", memberNo);
        param.put("targetNos", ids);
        bMapper.deleteSelectedBookmarks(param);
    }
    
    @Override
    public void deleteAllBookmarks(int memberNo) {
        bMapper.deleteAllBookmarks(memberNo);
    }
}
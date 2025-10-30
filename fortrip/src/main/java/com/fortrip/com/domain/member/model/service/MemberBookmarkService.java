package com.fortrip.com.domain.member.model.service;

import java.util.List;

import com.fortrip.com.domain.board.bookmark.model.vo.BookmarkVO;

public interface MemberBookmarkService {
    
    // 회원이 쓴 게시글 수
    int countMyPosts(int memberNo);
    
    // 내가 쓴 게시글이 받은 좋아요 수
    int countLikesOnMyPosts(int memberNo);
    
    // 내가 저장한 북마크 수
    int countMyBookmarks(int memberNo);
    
    // 북마크 목록 조회 (BookmarkVO 타입으로 통일)
    List<BookmarkVO> selectBookmarksByMember(int memberNo);
    
    // 선택 삭제
    void deleteSelectedBookmarks(int memberNo, List<Integer> ids);
    
    // 전체 삭제
    void deleteAllBookmarks(int memberNo);
}
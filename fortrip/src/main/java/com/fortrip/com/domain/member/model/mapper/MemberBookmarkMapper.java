package com.fortrip.com.domain.member.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.domain.board.bookmark.model.vo.BookmarkVO;

@Mapper
public interface MemberBookmarkMapper {
    
    // 북마크 존재 여부
    int existsBookmark(Map<String, Object> param);
    
    // 북마크 추가
    void insertBookmark(Map<String, Object> param);
    
    // 북마크 삭제
    void deleteBookmark(Map<String, Object> param);
    
    // 특정 게시글의 북마크 수
    int countBookmarkByBoard(Map<String, Object> param);
    
    // 회원이 쓴 게시글 수
    int countMyPosts(int memberNo);
    
    // 내가 쓴 게시글이 받은 좋아요 수
    int countLikesOnMyPosts(int memberNo);
    
    // 내가 저장한 북마크 수
    int countMyBookmarks(int memberNo);
    
    // 북마크 목록 조회 (BookmarkVO 타입으로 통일)
    List<BookmarkVO> selectBookmarksByMember(int memberNo);
    
    // 선택 삭제
    void deleteSelectedBookmarks(Map<String, Object> param);
    
    // 전체 삭제
    void deleteAllBookmarks(int memberNo);
}
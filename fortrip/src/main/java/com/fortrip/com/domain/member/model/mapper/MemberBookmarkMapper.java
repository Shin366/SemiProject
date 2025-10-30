package com.fortrip.com.domain.member.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fortrip.com.app.member.dto.MyBoard;
import com.fortrip.com.domain.board.bookmark.model.vo.BookmarkVO;

@Mapper
public interface MemberBookmarkMapper {

	 int existsBookmark(@Param("memberNo") int memberNo,
             @Param("targetType") String targetType,
             @Param("targetNo") int targetNo);

	 int insertBookmark(@Param("memberNo") int memberNo,
             @Param("targetType") String targetType,
             @Param("targetNo") int targetNo);

	 int deleteBookmark(@Param("memberNo") int memberNo,
             @Param("targetType") String targetType,
             @Param("targetNo") int targetNo);

	 int countBookmarkByBoard(@Param("targetType") String targetType,
                   @Param("targetNo") int targetNo);

	 List<Map<String, Object>> selectBookmarksByMember(int memberNo);

	 int countMyPosts(int memberNo);
	 int countLikesOnMyPosts(int memberNo);
	 int countMyBookmarks(int memberNo);

	 List<BookmarkVO> selectMyBookmarkList(int memberNo);

	 List<MyBoard> selectLikedBoards(int memberNo);

	 int deleteSelectedBookmarks(@Param("memberNo") int memberNo, @Param("targetNos") List<Integer> targetNos);
	 
	 int deleteAllBookmarks(int memberNo);

}

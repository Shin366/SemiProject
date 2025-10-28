package com.fortrip.com.domain.board.bookmark.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BookmarkMapper {

	 int existsBookmark(@Param("memberNo") int memberNo,
             @Param("targetType") String targetType,
             @Param("targetNo") int targetNo);

	 int insertBookmark(@Param("memberNo") int memberNo,
             @Param("targetType") String targetType,
             @Param("targetNo") int targetNo);

	 int deleteBookmark(@Param("memberNo") int memberNo,
             @Param("targetType") String targetType,
             @Param("targetNo") int targetNo);
}

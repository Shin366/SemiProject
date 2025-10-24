package com.fortrip.com.domain.comment.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.domain.comment.model.vo.Comment;

@Mapper
public interface CommentMapper {
	// 특정 게시글의 댓글 목록 조회
    List<Comment> selectCommentList(Map<String, Object> params);
    
    // 댓글 등록
    int insertComment(Comment comment);
    
    // 댓글 수정
    int updateComment(Comment comment);
    
    // 댓글 삭제 (논리적 삭제)
    int deleteComment(int commentNo);

}

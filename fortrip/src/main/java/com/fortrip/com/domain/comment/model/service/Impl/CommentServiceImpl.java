package com.fortrip.com.domain.comment.model.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fortrip.com.domain.comment.model.mapper.CommentMapper;
import com.fortrip.com.domain.comment.model.service.CommentService;
import com.fortrip.com.domain.comment.model.vo.Comment;
import com.fortrip.com.domain.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {
    
	private final CommentMapper commentMapper;

    @Override
    public List<Comment> getCommentList(String boardType, int boardNo) {
        // Mapper에 파라미터를 넘기기 위해 Map 사용 (혹은 @Param 어노테이션 사용)
        Map<String, Object> params = new HashMap<>();
        params.put("boardType", boardType);
        params.put("boardNo", boardNo);
        return commentMapper.selectCommentList(params);
    }

    @Override
    @Transactional // DB 변경 작업이므로 트랜잭션 처리
    public int addComment(Comment comment, Member loginMember) {
        // 로그인 정보가 없으면 등록 불가 (Controller에서도 체크하지만 Service에서도 방어)
        if (loginMember == null) {
            throw new IllegalArgumentException("로그인이 필요합니다.");
        }
        // 댓글 객체에 현재 로그인한 사용자 번호 설정
        comment.setMemberNo(loginMember.getMemberNo());
        return commentMapper.insertComment(comment);
    }

    @Override
    @Transactional
    public int updateComment(int commentNo, String content, Member loginMember) {
        if (loginMember == null) {
            throw new IllegalArgumentException("로그인이 필요합니다.");
        }

        // (중요) 댓글 작성자와 현재 로그인 사용자가 동일한지 확인하는 로직 필요
        // Comment originalComment = commentMapper.selectCommentById(commentNo); // ID로 댓글 조회 쿼리 추가 필요
        // if (originalComment == null || originalComment.getMemberNo() != loginMember.getMemberNo()) {
        //     throw new SecurityException("댓글 수정 권한이 없습니다.");
        // }

        Comment commentToUpdate = new Comment();
        commentToUpdate.setCommentNo(commentNo);
        commentToUpdate.setCommentContent(content);

        return commentMapper.updateComment(commentToUpdate);
    }

    @Override
    @Transactional
    public int deleteComment(int commentNo, Member loginMember) {
        if (loginMember == null) {
            throw new IllegalArgumentException("로그인이 필요합니다.");
        }

        // (중요) 댓글 작성자와 현재 로그인 사용자가 동일한지 확인하는 로직 필요
        // Comment originalComment = commentMapper.selectCommentById(commentNo); // ID로 댓글 조회 쿼리 추가 필요
        // if (originalComment == null || originalComment.getMemberNo() != loginMember.getMemberNo()) {
        //     throw new SecurityException("댓글 삭제 권한이 없습니다.");
        // }

        return commentMapper.deleteComment(commentNo);
    }
}
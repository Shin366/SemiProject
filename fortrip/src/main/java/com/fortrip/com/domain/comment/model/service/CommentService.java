package com.fortrip.com.domain.comment.model.service; // Use your designated comment package

import java.util.List;

import com.fortrip.com.domain.comment.model.vo.Comment;
import com.fortrip.com.domain.member.model.vo.Member;


public interface CommentService {

    /**
     * 특정 게시글의 댓글 목록 조회
     * @param boardType 게시판 타입 (e.g., "FREE", "QNA")
     * @param boardNo 게시글 번호
     * @return 댓글 목록
     */
    List<Comment> getCommentList(String boardType, int boardNo);

    /**
     * 댓글 등록
     * @param comment 등록할 댓글 정보 (boardType, boardNo, commentContent 필요)
     * @param loginMember 현재 로그인한 사용자 정보
     * @return 등록 성공 시 1, 실패 시 0
     */
    int addComment(Comment comment, Member loginMember);

    /**
     * 댓글 수정
     * @param commentNo 수정할 댓글 번호
     * @param content 수정할 내용
     * @param loginMember 현재 로그인한 사용자 정보 (작성자 확인용)
     * @return 수정 성공 시 1, 실패 시 0
     */
    int updateComment(int commentNo, String content, Member loginMember);

    /**
     * 댓글 삭제 (논리적 삭제)
     * @param commentNo 삭제할 댓글 번호
     * @param loginMember 현재 로그인한 사용자 정보 (작성자 확인용)
     * @return 삭제 성공 시 1, 실패 시 0
     */
    int deleteComment(int commentNo, Member loginMember);
}
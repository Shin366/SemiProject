package com.fortrip.com.domain.attachment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fortrip.com.domain.attachment.vo.Attachment;

@Mapper
public interface AttachmentMapper {
	
	// 첨부파일 등록
	int insertAttachment(Attachment attachment);
	
	// attachNo 목록으로 첨부파일 정보 여러 개 조회
    List<Attachment> selectAttachmentsByIds(List<Integer> attachNos);

    // attachNo 목록으로 첨부파일 여러 개 삭제
    int deleteAttachmentsByIds(List<Integer> attachNos);
    
    // 첨부파일 전체 삭제
	void deleteAttachmentsByBoard(String boardType, int boardNo);
	
	// 게시글타입 + 게시글 번호 첨부파일 전체 조회
	List<Attachment> selectAttachmentList(@Param("boardType") String boardType, @Param("boardNo") int boardNo);

}

package com.fortrip.com.domain.common.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.domain.common.model.vo.Attachment;

@Mapper
public interface AttachmentMapper {
	int insertAttachment(Attachment attachment);
	// attachNo 목록으로 첨부파일 정보 여러 개 조회
    List<Attachment> selectAttachmentsByIds(List<Integer> attachNos);

    // attachNo 목록으로 첨부파일 여러 개 삭제
    int deleteAttachmentsByIds(List<Integer> attachNos);
    
    // 첨부파일 전체 삭제
	List<Attachment> selectAttachmentList(String boardType, int boardNo);
	void deleteAttachmentsByBoard(String boardType, int boardNo);

}

package com.fortrip.com.domain.attachment.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.domain.attachment.vo.Attachment;

public interface AttachmentService {

	void saveFiles(List<MultipartFile> files, String boardType, int postNo) throws IOException;

	//첨부파일 고유번호 목록으로 특정 첨부파일들만 삭제
    void deleteFilesByIds(List<Integer> attachNos);

    // 특정 게시글에 해당하는 모든 첨부파일 삭제
	void deleteAttachmentsByBoard(String boardType, int boardNo);

	// 특정 게시판글의 해당 첨부파일 목록 조회
	List<Attachment> getAttachmentsByBoard(String boardType, int boardNo);
}

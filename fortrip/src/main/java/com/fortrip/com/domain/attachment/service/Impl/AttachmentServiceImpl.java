package com.fortrip.com.domain.attachment.service.Impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.domain.attachment.mapper.AttachmentMapper;
import com.fortrip.com.domain.attachment.service.AttachmentService;
import com.fortrip.com.domain.attachment.vo.Attachment;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class AttachmentServiceImpl implements AttachmentService{

	private final AttachmentMapper attachmentMapper;
	
	@Value("${file.upload-path}")
	private String uploadPath;

    @Override
    public List<String> saveFiles(List<MultipartFile> files, String boardType, int postNo) throws IOException {
        List<String> savedPaths = new ArrayList<>();

        if (files == null || files.isEmpty()) {
            return savedPaths;
        }

        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        for (MultipartFile file : files) {
            if (file.isEmpty()) continue;

            String originalName = file.getOriginalFilename();
            String ext = originalName.substring(originalName.lastIndexOf("."));
            String savedName = UUID.randomUUID().toString() + ext;

            // 실제 저장 파일 경로
            File dest = new File(dir, savedName);
            file.transferTo(dest);
            
            String webPath = "/uploads/" + savedName;

            // DB 저장
            Attachment attach = Attachment.builder()
                    .boardType(boardType)
                    .boardNo(postNo)
                    .originalName(originalName)
                    .savedName(savedName)
                    .attachPath(dest.getAbsolutePath())
                    .webPath(webPath)
                    .build();

            attachmentMapper.insertAttachment(attach);

            log.info("파일 저장 완료: {}", attach.getAttachPath());

            savedPaths.add(webPath);
        }

        return savedPaths;
    }
	@Override
	public void deleteFilesByIds(List<Integer> attachNos) {
		if (attachNos == null || attachNos.isEmpty()) {
            return;
        }

        // 1. DB에서 파일 정보를 먼저 조회 (물리적 파일을 지우기 위해)
        List<Attachment> attachmentsToDelete = attachmentMapper.selectAttachmentsByIds(attachNos);

        // 2. 물리적 파일 삭제
        for (Attachment attach : attachmentsToDelete) {
            File file = new File(attach.getAttachPath());
            if (file.exists()) {
                file.delete();
            }
        }

        // 3. DB에서 파일 메타데이터 삭제 (한 번의 쿼리로 처리)
        attachmentMapper.deleteAttachmentsByIds(attachNos);
    }

	@Override
	public void deleteAttachmentsByBoard(String boardType, int boardNo) {
		// 1. 물리적 파일을 삭제하기 위해 파일 정보는 먼저 조회
	    List<Attachment> attachments = attachmentMapper.selectAttachmentList(boardType, boardNo);

	    if (attachments == null || attachments.isEmpty()) {
	        return;
	    }

	    // 2. 서버에서 물리적 파일 삭제
	    for (Attachment attach : attachments) {
	        File fileToDelete = new File(attach.getAttachPath());
	        if (fileToDelete.exists()) {
	            fileToDelete.delete();
	        }
	    }

	    // 3. DB에서는 단 한 번의 쿼리로 모든 관련 데이터를 삭제
	    attachmentMapper.deleteAttachmentsByBoard(boardType, boardNo);
		
	}

	// 상세페이지 용 첨부파일 조회
	@Override
	public List<Attachment> getAttachmentsByBoard(String boardType, int boardNo) {
		return attachmentMapper.selectAttachmentList(boardType, boardNo);
	}

}

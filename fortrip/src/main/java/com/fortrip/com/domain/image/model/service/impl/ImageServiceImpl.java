package com.fortrip.com.domain.image.model.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.domain.image.model.mapper.ImageMapper;
import com.fortrip.com.domain.image.model.service.ImageService;
import com.fortrip.com.domain.image.model.vo.Image;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ImageServiceImpl implements ImageService {

    private final ImageMapper imageMapper;

    @Value("${file.upload-path}")
    private String uploadPath;

    @Transactional(rollbackFor = Exception.class)
    public void saveImage(MultipartFile file, String boardType, int boardNo, boolean isThumbnail) {
        if (file.isEmpty()) return;

        try {
            String originalName = file.getOriginalFilename();
            String savedName = UUID.randomUUID() + "_" + originalName;

            // 실제 파일 저장
            File saveFile = new File(uploadPath, savedName);
            file.transferTo(saveFile);

            // DB용 경로
            String imagePath = "/uploads/" + savedName;

            Image image = new Image();
            image.setBoardType(boardType);
            image.setBoardNo(boardNo);
            image.setImagePath(imagePath);
            image.setOriginalName(originalName);
            image.setSavedName(savedName);
            image.setIsThumbnail(isThumbnail ? "Y" : "N");

            imageMapper.insertImage(image);
            log.info("이미지 저장 완료: {}", image);

        } catch (IOException e) {
            log.error("이미지 저장 실패", e);
            throw new RuntimeException("이미지 저장 중 오류 발생", e);
        }
    }
}


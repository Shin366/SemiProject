package com.fortrip.com.domain.image.model.service;

import org.springframework.web.multipart.MultipartFile;

public interface ImageService {
	
	void saveImage(MultipartFile file, String boardType, int boardNo, boolean isThumbnail);

}

package com.fortrip.com.domain.image.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fortrip.com.domain.image.model.vo.Image;

@Mapper
public interface ImageMapper {

	int insertImage(Image image);

	void deleteImageByBoard(@Param("boardType") String boardType,
            @Param("boardNo") int boardNo);


}

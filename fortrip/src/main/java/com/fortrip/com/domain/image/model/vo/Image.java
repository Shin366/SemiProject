package com.fortrip.com.domain.image.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Image {
    private int imageNo;
    private String boardType;
    private int boardNo;
    private String imagePath;
    private String originalName;
    private String savedName;
    private String isThumbnail; // Y/N
    private String deleteYn;
}
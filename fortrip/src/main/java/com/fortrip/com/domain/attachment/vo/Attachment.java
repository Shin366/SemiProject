// Attachment.java
package com.fortrip.com.domain.attachment.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Attachment {
    private int attachNo;
    private String boardType;
    private int boardNo;
    private String originalName;
    private String savedName;
    private String attachPath;
}
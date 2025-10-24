package com.fortrip.com.app.board.notice.dto;

import com.fortrip.com.domain.board.notice.model.vo.BoardNotice;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardNoticeDetailDTO {
    private BoardNotice notice;       // 현재 공지사항
    private BoardNotice prevNotice;     // 이전 공지사항
    private BoardNotice nextNotice;     // 다음 공지사항
    
}
package com.fortrip.com.domain.board.notice.model.service;

import java.util.List;

import com.fortrip.com.app.board.notice.dto.BoardNoticeDetailDTO;
import com.fortrip.com.domain.board.notice.model.vo.BoardNotice;

public interface BoardNoticeService {

	BoardNoticeDetailDTO selectOneByNo(int noticeNo);

	int getTotalCount();

	List<BoardNotice> selectList(int currentPage, int boardCountPerPage);

	BoardNotice getBasicNoticeInfo(int pinnedNoticeNo);

}

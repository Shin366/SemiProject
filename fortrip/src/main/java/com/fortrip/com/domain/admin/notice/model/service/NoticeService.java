package com.fortrip.com.domain.admin.notice.model.service;

import java.util.List;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;

public interface NoticeService {

	int insertNotice(NoticeInsertDTO notice);
	/* 공지 리스트 가져오기 */
	List<NoticeVO> AllnoticeList();
}

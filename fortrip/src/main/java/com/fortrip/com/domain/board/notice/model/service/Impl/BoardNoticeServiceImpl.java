package com.fortrip.com.domain.board.notice.model.service.Impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.fortrip.com.app.board.notice.dto.BoardNoticeDetailDTO;
import com.fortrip.com.domain.board.notice.model.mapper.BoardNoticeMapper;
import com.fortrip.com.domain.board.notice.model.service.BoardNoticeService;
import com.fortrip.com.domain.board.notice.model.vo.BoardNotice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardNoticeServiceImpl implements BoardNoticeService{

	private final BoardNoticeMapper nMapper;
	
	@Override
	public BoardNoticeDetailDTO selectOneByNo(int noticeNo) {
		// 현재 게시글 정보 조회
		BoardNotice notice = nMapper.selectOneByNo(noticeNo);
		if (notice == null) {
            throw new IllegalArgumentException("존재하지 않는 공지사항입니다.");
        }
		
		// 이전글과 다음글 정보 조회
		BoardNotice prevNotice = nMapper.selectPrevNotice(noticeNo);
        BoardNotice nextNotice = nMapper.selectNextNotice(noticeNo);
        
        // 객체에 정보 담기
        BoardNoticeDetailDTO dto = new BoardNoticeDetailDTO();
        dto.setNotice(notice);
        dto.setPrevNotice(prevNotice);
        dto.setNextNotice(nextNotice);
        
		return dto;
	}

	@Override
	public int getTotalCount() {
		int totalCount = nMapper.getTotalCount();
		return totalCount;
	}

	@Override
	public List<BoardNotice> selectList(int currentPage, int boardCountPerPage) {
		int offset = (currentPage-1)*boardCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, boardCountPerPage);
		List<BoardNotice> nList = nMapper.selectNoticeList(rowBounds);
		return nList;
	}

	@Override
	public BoardNotice getBasicNoticeInfo(int pinnedNoticeNo) {
        BoardNotice notice = nMapper.selectOneByNo(pinnedNoticeNo);
        if (notice == null) {
            throw new IllegalArgumentException("존재하지 않는 공지사항입니다: " + pinnedNoticeNo);
        }
        return notice;
	}
}

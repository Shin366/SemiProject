package com.fortrip.com.domain.board.notice.model.service.Impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.fortrip.com.domain.board.notice.model.mapper.BoardNoticeMapper;
import com.fortrip.com.domain.board.notice.model.service.BoardNoticeService;
import com.fortrip.com.domain.board.notice.model.vo.BoardNotice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardNoticeServiceImpl implements BoardNoticeService{

	private final BoardNoticeMapper nMapper;
	
	@Override
	public BoardNotice selectOneByNo(int noticeNo) {
		BoardNotice notice = nMapper.selectOneByNo(noticeNo);
		return notice;
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

}

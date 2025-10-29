package com.fortrip.com.domain.admin.notice.model.service.Impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;
import com.fortrip.com.app.admin.notice.dto.NoticeModifyDTO;
import com.fortrip.com.domain.admin.notice.model.mapper.NoticeMapper;
import com.fortrip.com.domain.admin.notice.model.service.NoticeService;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService{

	private final NoticeMapper nMapper;
	/* 공지 삽입 */
	@Override
	public int insertNotice(NoticeInsertDTO notice) {
		int result = nMapper.insertNotice(notice);
		return result;
	}
	
	/* 공지 리스트 */
	@Override
	public List<NoticeVO> AllnoticeList(int currentPage, int noticeCountPerPage) {
		int offset = (currentPage-1) * noticeCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, noticeCountPerPage);
		List<NoticeVO> nList = nMapper.AllnoticeList(rowBounds);
		return nList;
	}
	
	/* 공지 리스트 갯수 & 페이징 */
	@Override
	public int getNoticeTotalCount() {
		int getTotalCount = nMapper.getNoticeTotalCount();
		return getTotalCount;
	}

	
	/* 공지 검색 리스트 */
	@Override
	public List<NoticeVO> SearchNoticeList(int currentPage, int noticeCountPerPage, String keyword) {
		int offset = (currentPage - 1) * noticeCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, noticeCountPerPage);
		List<NoticeVO> nList = nMapper.SearchNoticeList(rowBounds, keyword);
		return nList;
	}
	/* 공지 검색 게시물 갯수 */
	@Override
	public int getNoticeSearchCount(String keyword) {
		int getTotalCount = nMapper.getNoticeSearchCount(keyword);
		return getTotalCount;
	}
	
	/* 공지 삭제 */
	@Override
	public int noticeDelete(int noticeNo) {
		int result = nMapper.noticeDelete(noticeNo);
		return result;
	}
	
	/* 공지번호로 공지 찾기 */
	@Override
	public NoticeVO noticeInfoModify(int noticeNo) {
		// TODO Auto-generated method stub
		NoticeVO notice = nMapper.noticeInfoModify(noticeNo);
		return notice;
	}
	
	/* 공지 수정 */
	@Override
	public int noticeModify(NoticeModifyDTO notice) {
		// TODO Auto-generated method stub
		int result = nMapper.noticeModify(notice);
		return result;
	}
}
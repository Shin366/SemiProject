package com.fortrip.com.domain.admin.notice.model.service;

import java.util.List;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;
import com.fortrip.com.app.admin.notice.dto.NoticeModifyDTO;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;

public interface NoticeService {
	/* 공지 삽입 */
	int insertNotice(NoticeInsertDTO notice);
	/* 공지 삭제 */
	int noticeDelete(int noticeNo);
	
	/* 공지 리스트 가져오기 */
	List<NoticeVO> AllnoticeList(int currentPage, int noticeCountPerPage);
	/* 전체 게시물 & 페이징때 쓸 전체 게시물*/
	int getNoticeTotalCount();
	
	/* 키워드 공지 리스트 */
	List<NoticeVO> SearchNoticeList(int currentPage, int noticeCountPerPage, String keyword);
	/* 키워드 공지 게시물 갯수 */
	int getNoticeSearchCount(String keyword);
	
	/* 공지번호로 공지 찾기 */
	NoticeVO noticeInfoModify(int noticeNo);
	
	/* 공지 수정 */
	int noticeModify(NoticeModifyDTO notice);

	


}

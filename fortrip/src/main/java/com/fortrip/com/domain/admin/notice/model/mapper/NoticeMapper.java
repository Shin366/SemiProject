package com.fortrip.com.domain.admin.notice.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;
import com.fortrip.com.app.admin.notice.dto.NoticeModifyDTO;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;


@Mapper
public interface NoticeMapper {
	/* 공지 삽입 */
	int insertNotice(NoticeInsertDTO notice);

	/* 공지 페이징 */
	List<NoticeVO> AllnoticeList(RowBounds rowBounds);
	
	/* 전체 게시물 갯수 & 페이징에 필요한 전체 게시물 갯수*/
	int getNoticeTotalCount();

	/* 공지 검색 페이징*/
	List<NoticeVO> SearchNoticeList(RowBounds rowBounds, String keyword);
	/* 공지 검색 게시물 카운트 */
	int getNoticeSearchCount(String keyword);

	/* 공지 삭제 */
	int noticeDelete(int noticeNo);
	
	/* 공지번호로 공지 찾기 */
	NoticeVO noticeInfoModify(int noticeNo);

	/* 공지 수정 */
	int noticeModify(NoticeModifyDTO notice);
	
}

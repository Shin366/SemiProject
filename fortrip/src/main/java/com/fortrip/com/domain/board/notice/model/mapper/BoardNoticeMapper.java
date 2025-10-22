package com.fortrip.com.domain.board.notice.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fortrip.com.domain.board.notice.model.vo.BoardNotice;

@Mapper
public interface BoardNoticeMapper {
	BoardNotice selectOneByNo(int noticeNo);

	int getTotalCount();

	List<BoardNotice> selectNoticeList(RowBounds rowBounds);

}

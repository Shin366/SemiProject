package com.fortrip.com.domain.admin.notice.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;


@Mapper
public interface NoticeMapper {

	int insertNotice(NoticeInsertDTO notice);

	List<NoticeVO> AllnoticeList();
	
}

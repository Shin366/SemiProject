package com.fortrip.com.domain.admin.notice.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;


@Mapper
public interface NoticeMapper {

	int insertNotice(NoticeInsertDTO notice);

}

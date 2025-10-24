package com.fortrip.com.domain.admin.notice.model.service.Impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;
import com.fortrip.com.domain.admin.notice.model.mapper.NoticeMapper;
import com.fortrip.com.domain.admin.notice.model.service.NoticeService;
import com.fortrip.com.domain.admin.notice.model.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService{

	private final NoticeMapper nMapper;
	
	@Override
	public int insertNotice(NoticeInsertDTO notice) {
		// TODO Auto-generated method stub
		int result = nMapper.insertNotice(notice);
		return result;
	}

	@Override
	public List<NoticeVO> AllnoticeList() {
		// TODO Auto-generated method stub
		List<NoticeVO> nList = nMapper.AllnoticeList();
		return nList;
	}
}

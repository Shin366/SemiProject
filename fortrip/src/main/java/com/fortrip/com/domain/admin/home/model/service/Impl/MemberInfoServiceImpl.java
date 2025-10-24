package com.fortrip.com.domain.admin.home.model.service.Impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.fortrip.com.domain.admin.home.model.mapper.MemberInfoMapper;
import com.fortrip.com.domain.admin.home.model.service.MemberInfoService;
import com.fortrip.com.domain.admin.home.model.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberInfoServiceImpl implements MemberInfoService{
	
	private final MemberInfoMapper mMapper;
	
	@Override
	public int getMemberCount() {
		// TODO Auto-generated method stub
		int result = mMapper.getMemberCount();
		return result;
	}

	@Override
	public int getMemberActive() {
		// TODO Auto-generated method stub
		int result = mMapper.getMemberActive();
		return result;
	}

	@Override
	public int getMemberStop() {
		// TODO Auto-generated method stub
		int result = mMapper.getMemberStop();
		return result;
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		int getTotalCoun = mMapper.getTotalCount();
		return getTotalCoun;
	}

	@Override
	public List<MemberVO> getAllMember(int currentPage, int memberCountPerPage) {
		// TODO Auto-generated method stub
		int offset = (currentPage - 1) * memberCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, memberCountPerPage);
		List<MemberVO> mList = mMapper.getAllMember(rowBounds);
		return mList;
	}
}

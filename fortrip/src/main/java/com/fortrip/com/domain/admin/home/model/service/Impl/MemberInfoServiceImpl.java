package com.fortrip.com.domain.admin.home.model.service.Impl;

import java.util.List;

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
	public List<MemberVO> getAllMemeber() {
		// TODO Auto-generated method stub
		List<MemberVO> mList = mMapper.getAllMember();
		return mList;
	}

}

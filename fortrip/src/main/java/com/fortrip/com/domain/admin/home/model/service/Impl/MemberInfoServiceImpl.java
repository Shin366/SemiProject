package com.fortrip.com.domain.admin.home.model.service.Impl;

import java.util.List;
import java.util.Map;

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
		int result = mMapper.getMemberCount();
		System.out.println("회원 카운트:"+result);
		return result;
	}

	@Override
	public int getMemberActive() {
		int result = mMapper.getMemberActive();
		return result;
	}

	@Override
	public int getMemberStop() {
		int result = mMapper.getMemberStop();
		return result;
	}

	@Override
	public List<Map<String, Object>> getSignupChart() {
		List<Map<String, Object>> chartList = mMapper.getSignupChart();
		return chartList;
	}

	@Override
	public List<MemberVO> userList(int currentPage, int userCountPerPage) {
		int offset = (currentPage - 1) * userCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, userCountPerPage);
		List<MemberVO> mList = mMapper.userList(rowBounds);
		return mList;
	}

	@Override
	public int getTotalCount() {
		int getTotalCount = mMapper.getTotalCount();
		return getTotalCount;
	}

	@Override
	public int userDelete(int memberNo) {
		int result = mMapper.userDelete(memberNo);
		return result;
	}

	@Override
	public int getSearchCount(String keyword) {
		int getSearchCount = mMapper.getSearchCount(keyword);
		return getSearchCount;
	}

	@Override
	public List<MemberVO> userSearchList(int currentPage, int userCountPerPage, String keyword) {
		int offset = (currentPage - 1) * userCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, userCountPerPage);
		List<MemberVO> mList = mMapper.userSearchList(rowBounds, keyword);
		return mList;
	}

	@Override
	public int getfillterCount(String filter) {
		// TODO Auto-generated method stub
		int getFillterCount = mMapper.getFillterCount(filter);
		return getFillterCount;
	}

	@Override
	public List<MemberVO> userfillterList(int currentPage, int userCountPerPage, String filter) {
		// TODO Auto-generated method stub
		int offset = (currentPage - 1) * userCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, userCountPerPage);
		List<MemberVO> mList = mMapper.userFillterList(rowBounds, filter);
		return mList;
	}

	@Override
	public List<Map<String, Object>> getHotKeyWord() {
		// TODO Auto-generated method stub
		List<Map<String, Object>> keywordList = mMapper.getKeyWordChart();
		return keywordList;
	}
}

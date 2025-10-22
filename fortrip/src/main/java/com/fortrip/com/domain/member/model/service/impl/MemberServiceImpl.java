package com.fortrip.com.domain.member.model.service.impl;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.member.dto.JoinRequest;
import com.fortrip.com.app.member.dto.LoginRequest;
import com.fortrip.com.domain.member.model.mapper.MemberMapper;
import com.fortrip.com.domain.member.model.service.MemberService;
import com.fortrip.com.domain.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{
	
	private final MemberMapper mStore;
	
	@Override
	public int insertMember(JoinRequest member) {
		int result = mStore.insertMember(member);
		return result;
	}

	@Override
	public int insertMember() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Member seleteOneByLogin(LoginRequest member) {
		Member result = mStore.seleteByOneId(member);
		return null;
	}

	
}

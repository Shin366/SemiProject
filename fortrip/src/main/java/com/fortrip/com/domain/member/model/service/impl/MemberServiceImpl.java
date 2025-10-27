package com.fortrip.com.domain.member.model.service.impl;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.member.dto.JoinRequest;
import com.fortrip.com.app.member.dto.LoginRequest;
import com.fortrip.com.app.member.dto.ModifyRequest;
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
	public Member selectOneByLogin(LoginRequest member) {
		Member result = mStore.selectOneBylogin(member);
		return result;
	}


	@Override
	public Member selectOneById(String memberId) {
		Member result = mStore.selectOneById(memberId);
		return result;
	}

	@Override
	public int deleteMember(String memberId) {
		int result = mStore.deleteMember(memberId);
		return result;
	}

	@Override
	public int insertMember() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateMemberPw(String memberId, String encodedPw) {
		int result = mStore.updateMemberPw(memberId, encodedPw);
		return result;
	}

	@Override
	public Member findMemberId(Member member) {
		Member result = mStore.searchMemberId(member);
		return result;
	}

	@Override
	public int updateMember(ModifyRequest member) {
		int result = mStore.updateMember(member);
		return result;
	}



	
}

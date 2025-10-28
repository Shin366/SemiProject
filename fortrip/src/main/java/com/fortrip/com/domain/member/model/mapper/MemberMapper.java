package com.fortrip.com.domain.member.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.member.dto.JoinRequest;
import com.fortrip.com.app.member.dto.LoginRequest;
import com.fortrip.com.app.member.dto.ModifyRequest;
import com.fortrip.com.domain.member.model.vo.Member;

@Mapper
public interface MemberMapper {

	Member selectOneBylogin(LoginRequest member);

	int insertMember(JoinRequest member);

	int deleteMember(String memberId);

	Member selectOneById(String memberId);

	int updateTempMemberPw(String memberId, String encodedPw);

	Member searchMemberId(Member member);

	int updateMember(ModifyRequest member);

	
}
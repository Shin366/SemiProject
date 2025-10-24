package com.fortrip.com.domain.member.model.service;

import com.fortrip.com.app.member.dto.JoinRequest;
import com.fortrip.com.app.member.dto.LoginRequest;
import com.fortrip.com.domain.member.model.vo.Member;


public interface MemberService {

	int insertMember();

	int insertMember(JoinRequest member);

	Member selectOneByLogin(LoginRequest member);

	int deleteMember(String memberId);

	Member selectOneById(String memberId);

	int updateMemberPw(String memberId, String encodedPw);


}

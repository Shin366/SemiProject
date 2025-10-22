package com.fortrip.com.domain.member.model.service;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.member.dto.JoinRequest;
import com.fortrip.com.app.member.dto.LoginRequest;
import com.fortrip.com.domain.member.model.vo.Member;

@Service
public interface MemberService {

	int insertMember();

	int insertMember(JoinRequest member);

	Member seleteOneByLogin(LoginRequest member);


}

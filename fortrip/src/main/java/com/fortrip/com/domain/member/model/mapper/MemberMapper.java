package com.fortrip.com.domain.member.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.member.dto.JoinRequest;
import com.fortrip.com.app.member.dto.LoginRequest;
import com.fortrip.com.domain.member.model.vo.Member;

@Mapper
public interface MemberMapper {

	int insertMember(JoinRequest member);

	Member seleteByOneId(LoginRequest member);
	
}

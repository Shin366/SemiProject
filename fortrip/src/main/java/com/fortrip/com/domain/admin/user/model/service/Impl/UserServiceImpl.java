package com.fortrip.com.domain.admin.user.model.service.Impl;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.admin.user.dto.UserAddDTO;

import com.fortrip.com.app.admin.user.dto.UserModifyDTO;
import com.fortrip.com.domain.admin.user.model.mapper.UserMapper;
import com.fortrip.com.domain.admin.user.model.service.UserService;
import com.fortrip.com.domain.admin.user.model.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{
	
	private final UserMapper uMapper;
	
	@Override
	public int userAdd(UserAddDTO user) {
		// TODO Auto-generated method stub
		int result = uMapper.userAdd(user);
		return result;
	}

	@Override
	public UserVO userModifyInfo(int memberNo) {
		// TODO Auto-generated method stub
		UserVO member = uMapper.userModifyInfo(memberNo);
		return member;
	}

	@Override
	public int userModifyPost(UserModifyDTO user) {
		// TODO Auto-generated method stub
		int result = uMapper.userModifyPost(user);
		System.out.println("service : " + result);
		System.out.println("service : " + user);
		return result;
	}
}

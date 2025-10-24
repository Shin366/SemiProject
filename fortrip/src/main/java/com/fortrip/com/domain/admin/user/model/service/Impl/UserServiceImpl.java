package com.fortrip.com.domain.admin.user.model.service.Impl;

import org.springframework.stereotype.Service;

import com.fortrip.com.app.admin.user.dto.UserAddDTO;
import com.fortrip.com.domain.admin.user.model.mapper.UserMapper;
import com.fortrip.com.domain.admin.user.model.service.UserService;

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

}

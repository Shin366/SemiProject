package com.fortrip.com.domain.admin.user.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.admin.user.dto.UserAddDTO;


@Mapper
public interface UserMapper {

	int userAdd(UserAddDTO user);

}

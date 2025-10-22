package com.fortrip.com.domain.admin.user.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.admin.user.dto.UserAddDTO;
import com.fortrip.com.app.admin.user.dto.UserModifyDTO;
import com.fortrip.com.domain.admin.home.model.vo.MemberVO;
import com.fortrip.com.domain.admin.user.model.vo.UserVO;


@Mapper
public interface UserMapper {

	int userAdd(UserAddDTO user);

	UserVO userModifyInfo(int memberNo);

	int userModifyPost(UserModifyDTO user);
}

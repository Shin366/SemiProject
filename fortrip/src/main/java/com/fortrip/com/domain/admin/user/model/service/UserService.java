package com.fortrip.com.domain.admin.user.model.service;

import com.fortrip.com.app.admin.user.dto.UserAddDTO;
import com.fortrip.com.app.admin.user.dto.UserModifyDTO;
import com.fortrip.com.domain.admin.user.model.vo.UserVO;

public interface UserService {

	int userAdd(UserAddDTO user);

	UserVO userModifyInfo(int memberNo);

	int userModifyPost(UserModifyDTO user);

}

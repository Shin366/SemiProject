package com.fortrip.com.domain.admin.home.model.service;

import java.util.List;

import com.fortrip.com.domain.admin.home.model.vo.MemberVO;

public interface MemberInfoService {

	int getMemberCount();

	int getMemberActive();

	int getMemberStop();

	List<MemberVO> getAllMemeber();


}

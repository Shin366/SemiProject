package com.fortrip.com.domain.admin.home.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fortrip.com.domain.admin.home.model.vo.MemberVO;

@Mapper
public interface MemberInfoMapper {
	/* 전체 회원 수 */
	int getMemberCount();
	/* 활성 회원 수 */
	int getMemberActive();
	/* 활동 정지 회원 수 */
	int getMemberStop();
	/* 멤버 전체 가져오기 */
	int getTotalCount();
	List<MemberVO> getAllMember(RowBounds rowBounds);

}

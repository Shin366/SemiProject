package com.fortrip.com.domain.admin.home.model.mapper;

import java.util.List;
import java.util.Map;

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
	/* 회원 탈퇴 처리 */
	int userDelete(int memberNo);

	/* 회원 가입 통계 차트 */
	List<Map<String, Object>> getSignupChart();
	/* 키워드 차트 */
	List<Map<String, Object>> getKeyWordChart();
	
	/* 회원 전체 리스트 */
	List<MemberVO> userList(RowBounds rowBounds);
	/* 회원 전체 카운트 */
	int getTotalCount();
	
	/* 회원 검색  카운트 */
	int getSearchCount(String keyword);
	/* 회원 검색 리스트 */
	List<MemberVO> userSearchList(RowBounds rowBounds, String keyword);
	/* 회원 필터 카운트 */
	int getFillterCount(String filter);
	/* 회원 필터 리스트 */
	List<MemberVO> userFillterList(RowBounds rowBounds, String filter);

}

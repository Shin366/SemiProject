package com.fortrip.com.domain.admin.home.model.service;

import java.util.List;
import java.util.Map;

import com.fortrip.com.domain.admin.home.model.vo.MemberVO;

public interface MemberInfoService {
	/* 회원 전체 카운트 */
	int getMemberCount();
	/* 활성 회원 카운트 */
	int getMemberActive();
	/* 활동 정지 회원 카운트 */
	int getMemberStop();
	/* 유저 탈퇴 */
	int userDelete(int memberNo);

	/* 회원 가입 수 차트 */
	List<Map<String, Object>> getSignupChart();
	/* 핫 키워드 차트 */
	List<Map<String, Object>> getHotKeyWord();

	/* 회원 전체 리스트 fetch API */
	List<MemberVO> userList(int currentPage, int userCountPerPage);
	/* 회원 전체 리스트 페이징에 필요한 회원 전체 카운트 */
	int getTotalCount();
	
	
	/* 회원 검색 데이터 카운트 */
	int getSearchCount(String keyword);
	/* 회원 검색 데이터 검색 리스트 */
	List<MemberVO> userSearchList(int currentPage, int userCountPerPage, String keyword);
	
	/* 회원 필터 */
	int getfillterCount(String filter);
	/* 회원 필터 리스트 */
	List<MemberVO> userfillterList(int currentPage, int userCountPerPage, String filter);
	


}

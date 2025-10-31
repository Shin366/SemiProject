package com.fortrip.com.domain.member.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.domain.member.model.vo.CourseViewHistory;

@Mapper
public interface CourseViewHistoryMapper {

	int checkExistingView(Map<String, Object> param);

	void updateViewDate(Map<String, Object> param);

	void insertView(CourseViewHistory history);

	List<CourseViewHistory> selectRecentCourses(Map<String, Object> param);

	
	
}

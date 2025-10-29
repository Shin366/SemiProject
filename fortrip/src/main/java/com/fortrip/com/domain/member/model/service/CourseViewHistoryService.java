package com.fortrip.com.domain.member.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fortrip.com.domain.member.model.vo.CourseViewHistory;


@Service
public interface CourseViewHistoryService {

	void recordCourseView(long memberNo, long courseId, String string);

	List<CourseViewHistory> getRecentCourses(int memberNo);
	
	

	
}

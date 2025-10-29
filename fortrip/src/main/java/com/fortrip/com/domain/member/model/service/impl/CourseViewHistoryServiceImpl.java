package com.fortrip.com.domain.member.model.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fortrip.com.domain.member.model.mapper.CourseViewHistoryMapper;
import com.fortrip.com.domain.member.model.service.CourseViewHistoryService;
import com.fortrip.com.domain.member.model.vo.CourseViewHistory;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CourseViewHistoryServiceImpl implements CourseViewHistoryService{
	
	private CourseViewHistoryMapper mapper;
	
	@Override
	public void recordCourseView(long memberNo, long courseId, String courseType) {
        Map<String, Object> param = new HashMap<>();
        param.put("memberNo", memberNo);
        param.put("courseId", courseId);

        int exists = mapper.checkExistingView(param);

        if (exists > 0) {
            mapper.updateViewDate(param);
        } else {
            CourseViewHistory history = new CourseViewHistory();
            history.setMemberNo(memberNo);
            history.setCourseId(courseId);
            history.setCourseType(courseType);
            mapper.insertView(history);
        }
    }

	@Override
	public List<CourseViewHistory> getRecentCourses(long memberNo, int page, int pageSize) {
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        Map<String, Object> param = new HashMap<>();
        param.put("memberNo", memberNo);
        param.put("startRow", startRow);
        param.put("endRow", endRow);

        return mapper.selectRecentCourses(param);
    }

}

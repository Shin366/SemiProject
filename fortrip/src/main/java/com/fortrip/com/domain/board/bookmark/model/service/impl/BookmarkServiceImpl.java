package com.fortrip.com.domain.board.bookmark.model.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fortrip.com.domain.board.bookmark.model.mapper.BookmarkMapper;
import com.fortrip.com.domain.board.bookmark.model.service.BookmarkService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookmarkServiceImpl implements BookmarkService{
	  @Autowired
	    private BookmarkMapper mapper;

	    @Transactional
	    public boolean toggleBookmark(int memberNo, String targetType, int targetNo) {
	    	 boolean exists = mapper.existsBookmark(memberNo, targetType, targetNo) > 0;
	        if (exists) {
	            mapper.deleteBookmark(memberNo, targetType, targetNo);
	            return false;
	        } else {
	            mapper.insertBookmark(memberNo, targetType, targetNo);
	            return true;
	        }
	    }

	    public boolean isBookmarked(int memberNo, String targetType, int targetNo) {
	        return mapper.existsBookmark(memberNo, targetType, targetNo) > 0;
	    }

}

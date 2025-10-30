package com.fortrip.com.domain.board.free.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.board.free.dto.BoardFreeAddRequest;
import com.fortrip.com.app.board.free.dto.BoardFreeUpdateRequest;
import com.fortrip.com.domain.board.free.model.vo.BoardFree;

@Mapper
public interface BoardFreeMapper {

	BoardFree selectOneByNo(int postNo);

	int insertFree(BoardFreeAddRequest free);

	int getTotalCount();

	List<BoardFree> selectFreeList(int offset, int freeCountPerPage);

	int updateFree(BoardFreeUpdateRequest free);

	int increaseViewCount(int postNo); // 조회수 증가

	int deleteFree(int postNo);

	List<BoardFree> searchFreeBoardList(Map<String, Object> searchMap);

	int getTotalCountWithSearch(Map<String, Object> searchMap);

	void insertSearchKeyword(String searchKeyword);

}

package com.fortrip.com.domain.board.free.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.board.free.dto.BoardFreeAddRequest;
import com.fortrip.com.domain.board.free.model.vo.BoardFree;

@Mapper
public interface BoardFreeMapper {

	BoardFree selectOneByNo(int freeNo);

	int insertFree(BoardFreeAddRequest free);

	int getTotalCount();

	List<BoardFree> selectFreeList(int offset, int freeCountPerPage);


}

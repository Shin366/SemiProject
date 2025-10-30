package com.fortrip.com.domain.board.report.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fortrip.com.app.board.report.dto.BoardReportAddRequest;
import com.fortrip.com.app.board.report.dto.BoardReportUpdateRequest;
import com.fortrip.com.domain.board.report.model.vo.BoardReportVO;

@Mapper
public interface BoardReportMapper {

	int increaseViewCount(int reportNo);

	BoardReportVO selectOneByNo(int reportNo);

	int insertReport(BoardReportAddRequest report);

	int updateReport(BoardReportUpdateRequest reportUpdateDto);

	int deleteReport(int reportNo);

	int getTotalCount();

	List<BoardReportVO> selectReportList(int offset, int reportCountPerPage);


}

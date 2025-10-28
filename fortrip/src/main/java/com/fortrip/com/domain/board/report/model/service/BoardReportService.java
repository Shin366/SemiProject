package com.fortrip.com.domain.board.report.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.report.dto.BoardReportAddRequest;
import com.fortrip.com.app.board.report.dto.BoardReportUpdateRequest;
import com.fortrip.com.domain.board.report.model.vo.BoardReportVO;
import com.fortrip.com.domain.member.model.vo.Member;

public interface BoardReportService {

	BoardReportVO selectOneByNo(int reportNo);

	void increaseViewCount(int reportNo);


	int getTotalCount();

	List<BoardReportVO> selectReportList(int currentPage, int freeCountPerPage);

	int insertReport(BoardReportAddRequest report, List<MultipartFile> files, Member loginMember);

	int updateBoardReport(BoardReportUpdateRequest report, List<MultipartFile> reloadFiles, List<Integer> deletedFiles,
			Member loginMember);

	int deleteReport(int reportNo, Member loginMember);

}

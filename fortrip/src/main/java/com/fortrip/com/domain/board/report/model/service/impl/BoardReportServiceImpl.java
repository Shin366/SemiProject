package com.fortrip.com.domain.board.report.model.service.impl;

import java.io.IOException; // IOException import
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service; // Service import
import org.springframework.transaction.annotation.Transactional; // Transactional import
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.report.dto.BoardReportAddRequest;
import com.fortrip.com.app.board.report.dto.BoardReportUpdateRequest; // Update DTO import
import com.fortrip.com.domain.attachment.service.AttachmentService; // AttachmentService import
import com.fortrip.com.domain.board.report.model.mapper.BoardReportMapper; // Mapper import
import com.fortrip.com.domain.board.report.model.service.BoardReportService;
import com.fortrip.com.domain.board.report.model.vo.BoardReportVO;
import com.fortrip.com.domain.member.model.vo.Member;

import lombok.RequiredArgsConstructor; // RequiredArgsConstructor import
import lombok.extern.slf4j.Slf4j; // Log import

@Slf4j // 로그 사용
@Service // Service 어노테이션 추가
@RequiredArgsConstructor // 생성자 주입
public class BoardReportServiceImpl implements BoardReportService {

    private final BoardReportMapper reportMapper; // Mapper 주입
    private final AttachmentService attachmentService; // AttachmentService 주입
    private final BCryptPasswordEncoder passwordEncoder; // 비밀번호 암호화 인코더 주입

    private static final String BOARD_TYPE = "REPORT"; // 게시판 타입 상수

    @Override
    @Transactional // 조회수 증가(UPDATE) + 조회(SELECT) 포함
    public BoardReportVO selectOneByNo(int reportNo) {

        // 2. 신고 정보 조회 
        BoardReportVO report = reportMapper.selectOneByNo(reportNo);
        if (report == null) {
            throw new IllegalArgumentException("존재하지 않는 신고입니다: " + reportNo);
        }
        return report;
    }

    @Override
    @Transactional // DB UPDATE 작업이므로 트랜잭션 처리
    public void increaseViewCount(int reportNo) {
        reportMapper.increaseViewCount(reportNo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class) // DB 변경 + 파일 I/O
    public int insertReport(BoardReportAddRequest report, List<MultipartFile> files, Member loginMember) {
        if (loginMember == null) {
            throw new IllegalArgumentException("로그인 정보가 필요합니다.");
        }
     // 1. DTO에 회원 번호 및 고정 제목 설정
        report.setMemberNo(loginMember.getMemberNo());
        report.setReportTitle("신고합니다"); // 고정 제목 설정

        // 2. 비밀번호 암호화
        if (report.getReportPassword() != null && !report.getReportPassword().isEmpty()) {
            report.setReportPassword(passwordEncoder.encode(report.getReportPassword()));
        } else {
             // 비밀번호가 필수라면 여기서 예외 처리
             throw new IllegalArgumentException("열람용 비밀번호를 설정해야 합니다.");
        }

        // 3. 신고 내용 DB INSERT (Mapper에 insertReport 쿼리 필요)
        int result = reportMapper.insertReport(report);
        if (result == 0) {
            log.warn("신고 게시글 INSERT 실패: {}", report);
            return 0;
        }

        int reportNo = report.getReportNo(); // 생성된 PK 가져오기 (DTO에 getter 필요)

        // 4. 첨부파일 저장
        if (files != null && !files.isEmpty()) {
            try {
                attachmentService.saveFiles(files, BOARD_TYPE, reportNo);
            } catch (IOException e) {
                log.error("신고 {}번 글 파일 저장 실패", reportNo, e);
                // RuntimeException 발생 -> 트랜잭션 롤백
                throw new RuntimeException("파일 저장 실패", e);
            }
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class) // 여러 DB 작업 + 파일 I/O
    public int updateBoardReport(BoardReportUpdateRequest reportUpdateDto, List<MultipartFile> reloadFiles,
                                 List<Integer> deletedFiles, Member loginMember) { 

        if (loginMember == null) {
            throw new IllegalArgumentException("수정 권한 확인 실패: 로그인 정보가 없습니다.");
        }

        // 수정 대상 게시글 조회 (권한 확인용)
        BoardReportVO originalReport = reportMapper.selectOneByNo(reportUpdateDto.getReportNo());
        if (originalReport == null) {
            throw new IllegalArgumentException("수정하려는 신고가 존재하지 않습니다: " + reportUpdateDto.getReportNo());
        }

        // 수정 권한 확인
        if (originalReport.getMemberNo() != loginMember.getMemberNo()) {
            log.warn("수정 권한 없음: 신고 작성자={}, 요청자={}", originalReport.getMemberNo(), loginMember.getMemberNo());
            throw new SecurityException("신고 수정 권한이 없습니다.");
        }

        // 게시글 텍스트 내용 수정 
        int result = reportMapper.updateReport(reportUpdateDto);
        if (result == 0) {
            log.warn("신고 게시글 UPDATE 실패: {}", reportUpdateDto);
            return 0;
        }

        // 기존 파일 삭제
        if (deletedFiles != null && !deletedFiles.isEmpty()) {
            try {
                attachmentService.deleteFilesByIds(deletedFiles);
            } catch (Exception e) {
                log.error("기존 첨부파일 삭제 중 오류 발생: {}", deletedFiles, e);
                throw new RuntimeException("기존 첨부파일 삭제 중 오류가 발생했습니다.", e);
            }
        }

        // 새 파일 저장
        if (reloadFiles != null && !reloadFiles.isEmpty()) {
            try {
                attachmentService.saveFiles(reloadFiles, BOARD_TYPE, reportUpdateDto.getReportNo());
            } catch (IOException e) {
                log.error("새 첨부파일 저장 중 오류 발생: reportNo={}", reportUpdateDto.getReportNo(), e);
                throw new RuntimeException("신고 수정 중 파일 저장에 실패했습니다.", e);
            }
        }
        return result;
    }


    @Override
    @Transactional(rollbackFor = Exception.class) // 여러 DB 작업 + 파일 I/O
    public int deleteReport(int reportNo, Member loginMember) { 
        if (loginMember == null) {
            throw new IllegalArgumentException("삭제 권한 확인 실패: 로그인 정보가 없습니다.");
        }

        // 삭제 대상 게시글 조회 (권한 확인용)
        BoardReportVO originalReport = reportMapper.selectOneByNo(reportNo);
        if (originalReport == null) {
            // 이미 삭제되었거나 없는 글일 경우, 성공 처리 또는 예외 발생 선택 가능
            log.warn("삭제 대상 신고 없음: reportNo={}", reportNo);
            return 0; // 또는 throw new IllegalArgumentException(...)
        }

        // 삭제 권한 확인
        if (originalReport.getMemberNo() != loginMember.getMemberNo()) {
            log.warn("삭제 권한 없음: 신고 작성자={}, 요청자={}", originalReport.getMemberNo(), loginMember.getMemberNo());
            throw new SecurityException("신고 삭제 권한이 없습니다.");
        }

        // 첨부파일 전체 삭제
        try {
            attachmentService.deleteAttachmentsByBoard(BOARD_TYPE, reportNo);
        } catch (Exception e) {
             log.error("신고 {}번 글 첨부파일 삭제 중 오류 발생", reportNo, e);
             throw new RuntimeException("첨부파일 삭제 중 오류가 발생했습니다.", e);
        }

        // 게시글 논리 삭제
        return reportMapper.deleteReport(reportNo);
    }

    @Override
    public int getTotalCount() { 
        return reportMapper.getTotalCount();
    }

    @Override
    public List<BoardReportVO> selectReportList(int currentPage, int reportCountPerPage) {
        int offset = (currentPage - 1) * reportCountPerPage;
        return reportMapper.selectReportList(offset, reportCountPerPage);
    }
}
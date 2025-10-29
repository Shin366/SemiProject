package com.fortrip.com.app.board.report.controller;

import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.report.dto.BoardReportAddRequest;
import com.fortrip.com.app.board.report.dto.BoardReportUpdateRequest;
import com.fortrip.com.domain.attachment.service.AttachmentService; // AttachmentService import
import com.fortrip.com.domain.attachment.vo.Attachment; // Attachment VO import
import com.fortrip.com.domain.board.notice.model.service.BoardNoticeService;
import com.fortrip.com.domain.board.notice.model.vo.BoardNotice;
import com.fortrip.com.domain.board.report.model.service.BoardReportService;
import com.fortrip.com.domain.board.report.model.vo.BoardReportVO;
import com.fortrip.com.domain.comment.model.service.CommentService;
import com.fortrip.com.domain.comment.model.vo.Comment;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j; // Log import

@Slf4j // 로그 사용
@Controller
@RequestMapping("/board/report")
@RequiredArgsConstructor
public class BoardReportController {

    private final BoardReportService reportService;
    private final BoardNoticeService nService; // 고정 공지용
    private final AttachmentService attachmentService; // 첨부파일용
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    private final CommentService commentService;

    // 신고 상세페이지 
    @GetMapping("/detail")
    public String showDetailView(
            @RequestParam("reportNo") Integer reportNo,
            @RequestParam(value = "reportPassword", required = false) String inputPassword,
            HttpSession session,
            Model model) {
        try {
            if (reportNo == null) {
                 model.addAttribute("errorMsg", "잘못된 신고 번호입니다.");
                 return "common/error";
            }
            
            //신고글 조회
            BoardReportVO report = reportService.selectOneByNo(reportNo);
            if (report == null) {
                model.addAttribute("errorMsg", "잘못된 신고 번호입니다.");
                return "common/error";
           }
            
         // 로그인 사용자 확인
            Member loginMember = (Member) session.getAttribute("loginMember");

            // adminYN == 'Y' 이면 관리자
            boolean isAdmin = loginMember != null 
                              && "Y".equalsIgnoreCase(loginMember.getAdminYn());
            

            if (!isAdmin) { // 관리자는 무조건 접근 허용
                if (report.getReportPassword() != null && !report.getReportPassword().isEmpty()) {
                	model.addAttribute("reportNo", reportNo);
                    if (inputPassword == null) {
                        // 비밀번호 입력 페이지로 이동
                    	
                    	 log.info("입력한 비밀번호: [{}]", inputPassword);
                         log.info("DB 저장된 비밀번호: [{}]", report.getReportPassword());
                        model.addAttribute("reportNo", reportNo);
                        
                        return "board/report/password";
                    }
                    if (!passwordEncoder.matches(inputPassword, report.getReportPassword())) {
                        model.addAttribute("reportNo", reportNo);
                        model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
                        return "board/report/password";
                    }
                }
            }
            
            // 첨부파일 조회 
            List<Attachment> attachmentList = attachmentService.getAttachmentsByBoard("REPORT", reportNo);
            
            // 댓글 조회
            List<Comment> commentList = commentService.getCommentList("REPORT", reportNo);
            
            model.addAttribute("report", report); 
            model.addAttribute("attachmentList", attachmentList);
            model.addAttribute("commentList", commentList); 
            
            return "board/report/detail";
        } catch (IllegalArgumentException e) {
             log.warn("신고 상세 조회 실패: {}", e.getMessage());
             model.addAttribute("errorMsg", e.getMessage());
             return "common/error";
        } catch (Exception e) {
            log.error("신고 상세 조회 중 오류: reportNo={}", reportNo, e);
            model.addAttribute("errorMsg", "신고 조회 중 오류가 발생했습니다.");
            return "common/error";
        }
    }

    // 신고게시판 작성페이지 출력
    @GetMapping("/insert")
    public String showReportAddView(HttpSession session, Model model) {
        // 로그인 확인 방식을 "loginMember" 객체로 통일
        if (session.getAttribute("loginMember") == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "common/error";
        }
        return "board/report/insert";
    }

    // 신고게시판 작성페이지 실행로직
    @PostMapping("/insert")
    public String insertReport(
            @ModelAttribute BoardReportAddRequest report,
            @RequestParam(value="files", required=false) List<MultipartFile> files,
            HttpSession session,
            Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "common/error";
        }
        try {
             int result = reportService.insertReport(report, files, loginMember);
            return "redirect:/board/report/list"; // 리다이렉트 경로 수정
        } catch (Exception e) {
            log.error("신고 등록 오류", e);
            model.addAttribute("errMsg", "신고 등록 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
//
//    // 신고게시판 수정페이지 출력
//    @GetMapping("/update")
//    public String showModifyView(
//            @RequestParam int reportNo, // Integer 사용 권장
//            HttpSession session,
//            Model model) {
//        try {
//            // (개선) 수정 페이지 접근 권한 확인 로직 추가 권장
//            Member loginMember = (Member) session.getAttribute("loginMember");
//            BoardReportVO report = reportService.selectOneByNo(reportNo); // 조회수 증가 없는 조회 메소드 필요 시 추가
//
//            if (loginMember == null || report.getMemberNo() != loginMember.getMemberNo()) {
//                 model.addAttribute("errorMsg", "수정 권한이 없습니다.");
//                 return "common/error";
//            }
//            // 첨부파일 목록 조회
//            List<Attachment> attachmentList = attachmentService.getAttachmentsByBoard("REPORT", reportNo);
//
//            model.addAttribute("report", report);
//            model.addAttribute("attachmentList", attachmentList);
//            return "board/report/update"; // 맨 앞 '/' 제거
//        } catch (IllegalArgumentException e) {
//             log.warn("신고 수정 페이지 접근 실패: {}", e.getMessage());
//             model.addAttribute("errorMsg", e.getMessage());
//             return "common/error";
//        } catch (Exception e) {
//            log.error("신고 수정 페이지 로딩 중 오류", e);
//            model.addAttribute("errorMsg", "페이지 로딩 중 오류가 발생했습니다.");
//            return "common/error";
//        }
//    }
//
//    // 신고게시판 수정 구현
//    @PostMapping("/update")
//    public String updateReport( // 메소드 이름 updateFreeOne -> updateReport
//            @ModelAttribute BoardReportUpdateRequest report, // 파라미터 이름 free -> report, DTO 타입 확인
//            @RequestParam(value="reloadFiles", required=false) List<MultipartFile> reloadFiles,
//            @RequestParam(value="deletedFiles", required=false) List<Integer> deletedFiles,
//            HttpSession session,
//            Model model) {
//        Member loginMember = (Member) session.getAttribute("loginMember");
//        if (loginMember == null) {
//            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
//            return "common/error";
//        }
//
//        try {
//             // Service 메소드 이름 updateBoardReport 확인 필요
//             int result = reportService.updateBoardReport(report, reloadFiles, deletedFiles, loginMember);
//             // 리다이렉트 파라미터 이름 postNo -> reportNo 로 수정
//             return "redirect:/board/report/detail?reportNo=" + report.getReportNo();
//        } catch (SecurityException | IllegalArgumentException e) {
//            log.warn("신고 수정 실패: {}", e.getMessage());
//            model.addAttribute("errorMsg", e.getMessage());
//            return "common/error";
//        } catch (Exception e) {
//            log.error("신고 수정 오류: reportNo={}", report.getReportNo(), e);
//            model.addAttribute("errorMsg", "신고 수정 중 오류가 발생했습니다.");
//            return "common/error";
//        }
//    }

    // 게시글 삭제 구현
    @PostMapping("/delete") // GetMapping -> PostMapping 변경
    public String deleteReport(
            @RequestParam("reportNo") int reportNo, // 파라미터 이름 오타 수정
            HttpSession session, // 권한 확인을 위해 HttpSession 추가
            Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "common/error";
        }

        try {
             // Service 메소드 호출 시 loginMember 전달 (Service 내부에서 권한 확인)
             int result = reportService.deleteReport(reportNo, loginMember); // Service 인터페이스/구현체 수정 필요
             if (result > 0) {
                 log.info("신고 글 삭제 성공: reportNo={}", reportNo);
                 return "redirect:/board/report/list";
             } else {
                  log.warn("신고 글 삭제 실패 (권한 없음 또는 대상 없음): reportNo={}", reportNo);
                  model.addAttribute("errorMsg", "게시글 삭제에 실패했습니다.");
                  return "common/error";
             }
        } catch (SecurityException | IllegalArgumentException e) {
             log.warn("삭제 실패: {}", e.getMessage());
             model.addAttribute("errorMsg", e.getMessage());
             return "common/error";
        } catch (Exception e) {
            log.error("신고 삭제 오류: reportNo={}", reportNo, e);
            model.addAttribute("errorMsg", "게시글 삭제 중 오류가 발생했습니다.");
            return "common/error";
        }
    }

    // 신고게시판 목록 조회
    @GetMapping("/list")
    public String showBoardListView(
            @RequestParam(value="page", defaultValue="1") int currentPage,
            Model model) {
        try {
            // 고정 공지 조회
            try {
                int pinnedNoticeNo = 1;
                BoardNotice pinnedNotice = nService.getBasicNoticeInfo(pinnedNoticeNo);
                model.addAttribute("pinnedNotice", pinnedNotice);
            } catch (IllegalArgumentException e) {
                // 공지 못찾아도 목록은 보여주도록 수정
                log.warn("고정 공지({})를 찾을 수 없습니다. 목록 조회는 계속 진행합니다.", 1);
                // model.addAttribute("errorMsg", e.getMessage()); // 에러 메시지 대신 로그만 남김
                // return "common/error"; // 에러 페이지로 가지 않음
            }

            int totalCount = reportService.getTotalCount();
            int reportCountPerPage = 5; // 변수명 수정

            int maxPage = (int)Math.ceil((double)totalCount / reportCountPerPage);
            List<BoardReportVO> reportList = reportService.selectReportList(currentPage, reportCountPerPage);

            int naviCountPerPage = 6;
            int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
            int endNavi = startNavi + naviCountPerPage - 1; // 계산식 수정
            if(endNavi > maxPage) endNavi = maxPage;

            model.addAttribute("currentPage", currentPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            model.addAttribute("reportList", reportList);

            return "board/report/list";
        } catch(Exception e) {
            log.error("신고 목록 조회 오류", e);
            model.addAttribute("errorMsg", "목록 조회 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
}
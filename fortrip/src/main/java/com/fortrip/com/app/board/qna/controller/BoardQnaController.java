package com.fortrip.com.app.board.qna.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.board.qna.dto.BoardQnaAddRequest;
import com.fortrip.com.app.board.qna.dto.BoardQnaUpdateRequest;
import com.fortrip.com.domain.attachment.service.AttachmentService;
import com.fortrip.com.domain.attachment.vo.Attachment;
import com.fortrip.com.domain.board.qna.model.mapper.BoardQnaMapper;
import com.fortrip.com.domain.board.qna.model.service.BoardQnaService;
import com.fortrip.com.domain.board.qna.model.vo.BoardQna;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board/qna")
public class BoardQnaController { // 문의게시판 컨트롤러
	
	private final BoardQnaMapper qMapper;
	private final BoardQnaService qService;
	private final AttachmentService attachmentService;
	private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	
	// 문의게시판 목록 조회
	@GetMapping("/list")
	public String showQnaList(
			@RequestParam(value="page", defaultValue="1") int currentPage
			,Model model) {
		try {
			int totalCount = qService.getTotalCount();			// 전체 게시물 갯수
			int boardCountPerPage = 5;		// 한 페이지당 보여주는 게시물의 갯수
			int maxPage = totalCount % boardCountPerPage != 0 
								? totalCount/boardCountPerPage + 1 
										: totalCount/boardCountPerPage;				// 전체 페이지 수
			maxPage = (int)Math.ceil((double)totalCount/boardCountPerPage); 
			List<BoardQna> qList = qService.selectQnaList(currentPage, boardCountPerPage);
			int naviCountPerPage = 5;		// 한 페이징당 보여주는 페이지의 갯수
			// currentPage: 1 ~ 5, startNavi: 1, endNavi: 5*1
			// currentPage: 6 ~ 10, startNavi: 6, endNavi: 10 = 5*2
			// currentPage: 11 ~ 15, startNavi: 11, endNavi: 15 = 5*3			
			int startNavi = ((currentPage-1)/naviCountPerPage)*naviCountPerPage+1;	// 네비의 시작값
			int endNavi = (startNavi-1)+naviCountPerPage;							// 네비의 끝값
			if(endNavi > maxPage) endNavi = maxPage;
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("qList", qList);
			return "board/qna/list";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	// 문의게시판 상세페이지
	@GetMapping("/detail")
	public String showDetailView(
			@RequestParam("qnaNo") Integer qnaNo,
			@RequestParam(value = "qnaPassword", required = false) String inputPassword,
            HttpSession session,
			Model model) {
		try {
			// 게시글 조회
			BoardQna boardQna = qService.selectOneByNo(qnaNo);
			if (boardQna == null) {
	               model.addAttribute("errorMsg", "존재하지 않는 문의글입니다.");
	               return "common/error";
	           }
			

            Member loginMember = (Member) session.getAttribute("loginMember");
            boolean isAdmin = loginMember != null && "Y".equalsIgnoreCase(loginMember.getAdminYn());
            boolean isWriter = loginMember != null && loginMember.getMemberNo() == boardQna.getMemberNo();
			
            // 비밀글 확인
            if ("Y".equalsIgnoreCase(boardQna.getIsPrivate())) {
                if (!(isAdmin || isWriter)) {
                    // 비밀번호가 설정된 경우
                    if (boardQna.getQnaPassword() != null && !boardQna.getQnaPassword().isEmpty()) {
                        if (inputPassword == null) {
                            model.addAttribute("qnaNo", qnaNo);
                            return "board/qna/password";
                        }
                        if (!passwordEncoder.matches(inputPassword, boardQna.getQnaPassword())) {
                            model.addAttribute("qnaNo", qnaNo);
                            model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
                            return "board/qna/password";
                        }
                    }
                }
            }
            
			//첨부파일 조회
			List<Attachment> attachmentList = attachmentService.getAttachmentsByBoard("QNA", qnaNo);
			model.addAttribute("boardQna", boardQna);
			model.addAttribute("attachmentList", attachmentList);
			
			return "board/qna/detail"; 
			
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
		
	}
	
	// 문의게시판 삭제
	@GetMapping("/delete")
	public String deleteQnaOne(
			@RequestParam int qnaNo
			,Model model) {
		try {
			// 첨부파일 전체 삭제
	        attachmentService.deleteAttachmentsByBoard("QNA", qnaNo);

	        // 게시글 삭제
	        qService.deleteQna(qnaNo);

	        // 삭제 후 목록으로 리다이렉트
	        return "redirect:/board/qna/list";
		}catch(Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	// 문의게시판 수정
	@GetMapping("/update")
	public String showUpdateView(
			@RequestParam int qnaNo
			,HttpSession session
			,Model model) {
		try {
			BoardQna boardQna = qService.selectOneByNo(qnaNo);
			model.addAttribute("boardQna", boardQna);
			return "board/qna/update";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
	
	@PostMapping("/update")
	public String updateQnaOne(
			@ModelAttribute BoardQnaUpdateRequest qna,
	        @RequestParam(value="reloadFiles", required=false) List<MultipartFile> reloadFiles,
	        // 추가: 삭제할 파일의 attachNo 목록을 받음
	        @RequestParam(value="deletedFiles", required=false) List<Integer> deletedFiles,
	        HttpSession session,
	        Model model) {
		// 로그인 정보 가져오기
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		// (보안) 비로그인 사용자 차단
	    if (loginMember == null) {
	        model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
	        return "common/error";
	    }
	    
	    try {
	        // 서비스에 삭제할 파일 ID 목록도 함께 전달
	        int result = qService.updateBoardQna(qna, reloadFiles, deletedFiles);
	        return "redirect:/board/qna/detail?qnaNo=" + qna.getQnaNo();
	    } catch (Exception e) {
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
	}
	
	// 문의게시판 작성
	@GetMapping("/insert")
	public String showQnaAddView(
			HttpSession session, Model model) {
		Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            throw new IllegalArgumentException("로그인 정보가 필요합니다.");
        }
		return "board/qna/insert";
	}
	
	@PostMapping("/insert")
	@ResponseBody
	public int insertQna(
	        @ModelAttribute BoardQnaAddRequest qna,
	        @RequestParam(value="files", required=false) List<MultipartFile> files,
	        HttpSession session,
	        Model model) {

	    Member loginMember = (Member) session.getAttribute("loginMember");
	    if (loginMember == null) {
	        throw new IllegalArgumentException("로그인 정보가 필요합니다.");
	    }

	    qna.setMemberNo(loginMember.getMemberNo());
	    
	 // 비밀글 체크 시 암호화
        if ("Y".equalsIgnoreCase(qna.getIsPrivate()) && qna.getQnaPassword() != null && !qna.getQnaPassword().isEmpty()) {
            qna.setQnaPassword(passwordEncoder.encode(qna.getQnaPassword()));
        }
	    int result = qService.insertQna(qna, files, loginMember);
	    if (result == 0) return 0;

	    int qnaNo = qna.getQnaNo();
	    if (files != null && !files.isEmpty()) {
	        try {
	            attachmentService.saveFiles(files, "QNA", qnaNo);
	        } catch (IOException e) {
	            throw new RuntimeException("Q&A 게시글 파일 저장에 실패했습니다.", e);
	        }
	    }
	    return result;
	}

	
	// 문의게시판 검색 - 구현 예정
	
	

}

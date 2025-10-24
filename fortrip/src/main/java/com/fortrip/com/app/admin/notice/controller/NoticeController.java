package com.fortrip.com.app.admin.notice.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.admin.notice.dto.NoticeInsertDTO;
import com.fortrip.com.domain.admin.notice.model.service.NoticeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/notice")
@RequiredArgsConstructor
public class NoticeController {
	
	private final NoticeService nService;
	
	@GetMapping("/insert")
	public String noticePage() {
		return "admin/notice/noticeInsert";
	}
	
	@PostMapping("/insert")
	public String noticeInsert(@ModelAttribute NoticeInsertDTO notice
			,@RequestParam(value="uploadfile", required=false) MultipartFile uploadfile
			,Model model, HttpSession session) {
		try {
			String attachmentName = null;
			String attachmentPath = null;
			if(uploadfile != null && !uploadfile.getOriginalFilename().isBlank()) {
				attachmentName = uploadfile.getOriginalFilename();
				
				// 실제 데이터(파일)를 경로에 저장
				String folderPath = session.getServletContext().getRealPath("/resources/noticeFiles/"); // resources의 실제 경로 가져옴
				uploadfile.transferTo(new File(folderPath+"\\"+ attachmentName));
				
				// DB에 저장할 데이터, 실제 데이터(파일)는 저장x
				attachmentPath = "/resources/noticeFiles/" + attachmentName; // 첨부파일 경로
				notice.setAttachmentName(attachmentName);
				notice.setAttachmentPath(attachmentPath);
			}
			int result = nService.insertNotice(notice);
			return "admin/notice/noticeInsert";
		} catch (Exception e) {
			e.printStackTrace();
			return "admin/notice/noticeInsert";
		}
	}

}

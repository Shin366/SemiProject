package com.fortrip.com.app.journey.trip.controller;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.fortrip.com.app.journey.trip.dto.TripCreateForm;
import com.fortrip.com.app.journey.trip.dto.TripRequest;
import com.fortrip.com.app.journey.trip.dto.TripUpdateForm;
import com.fortrip.com.app.journey.trip.dto.TripView;
import com.fortrip.com.domain.journey.trip.model.service.TripService;
import com.fortrip.com.domain.journey.trip.model.vo.Trip;
import com.fortrip.com.domain.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/trip")
@RequiredArgsConstructor
public class TripController {

    private final TripService tripService;

    // 목록 + 검색
    @GetMapping({"/course", "/search"})
    public String courseList(@ModelAttribute TripRequest req, Model model) {
        List<TripView> courses = tripService.findTrips(req);
        int total = tripService.countTrips(req);
        int totalPages = (int) Math.ceil((double) total / req.getSize());
        model.addAttribute("courses", courses);
        model.addAttribute("page", req.getPage());
        model.addAttribute("size", req.getSize());
        model.addAttribute("totalPages", totalPages);
        return "trip/course";
    }

    // 상세
    @GetMapping("/course/{id}")
    public String courseDetail(@PathVariable int id, Model model) {
        TripView course = tripService.findTrip(id);
        if (course == null) return "redirect:/trip/course";
        model.addAttribute("course", course);
        return "trip/coursedetail";
    }

    // 등록 폼
    // 등록 처리
    @PostMapping("course/insert")
    public String insertCourse(@ModelAttribute TripCreateForm form,
                               @RequestParam(value = "thumbnail", required = false) MultipartFile thumbnail,
                               HttpSession session) throws Exception {

        // 1) 세션에서 로그인 멤버 가져오기 (MemberController에서 이렇게 넣음)
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            // 비로그인 → 로그인 페이지로
            return "redirect:/member/login?beforeURL=/trip/add";
        }
        Integer loginMemberNo = loginMember.getMemberNo();

        // 2) 폼 -> VO 매핑
        Trip vo = form.toTripVo();
        vo.setMemberNo(loginMemberNo); // ROAD.MEMBER_NO

        // 3) 썸네일 파일 저장 (ROAD 테이블에 썸네일 컬럼 아직 없으면 파일만 저장)
        if (thumbnail != null && !thumbnail.isEmpty()) {
            String folderPath = session.getServletContext().getRealPath("/resources/tripThumb/");
            java.io.File dir = new java.io.File(folderPath);
            if (!dir.exists()) dir.mkdirs();

            String savedName = System.currentTimeMillis() + "_" + thumbnail.getOriginalFilename();
            java.io.File dest = new java.io.File(dir, savedName);
            thumbnail.transferTo(dest);

            // 나중에 ROAD 테이블에 THUMB_URL 추가하면:
            // vo.setThumbUrl("/resources/tripThumb/" + savedName);
        }

        // 4) INSERT 실행
        int result = tripService.createTrip(vo); // TripService에 메서드 추가되어 있어야 함

        // 5) 리다이렉트
        return "redirect:/trip/course";
    }

    // 수정 폼
    @GetMapping("/course/{id}/edit")
    public String courseEditForm(@PathVariable int id, Model model) {
        TripView course = tripService.findTrip(id);
        if (course == null) return "redirect:/trip/course";
        model.addAttribute("course", course);
        return "trip/tripEdit"; // 만들어서 사용
    }

    // 수정 처리
    @PostMapping("/course/{id}/edit")
    public String courseEdit(@PathVariable int id,
                             @ModelAttribute TripUpdateForm form,
                             HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/member/login?beforeURL=/trip/course/" + id + "/edit";

        Integer memberNo = loginMember.getMemberNo();

        // adminYn은 문자열 "Y"/"N" 으로 저장됨
        String adminYn = (String) session.getAttribute("adminYn");
        boolean admin = "Y".equals(adminYn);

        form.setId(id);
        tripService.updateTrip(form, memberNo, admin);
        return "redirect:/trip/course/" + id;
    }

    // 삭제(소프트)
    @PostMapping("/course/{id}/delete")
    public String courseDelete(@PathVariable int id, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/member/login?beforeURL=/trip/course/" + id;

        Integer memberNo = loginMember.getMemberNo();
        String adminYn = (String) session.getAttribute("adminYn");
        boolean admin = "Y".equals(adminYn);

        tripService.deleteTrip(id, memberNo, admin);
        return "redirect:/trip/course";
    }
    
    @GetMapping("/add") public String courseAdd() { return "trip/tripAdd"; }
    @GetMapping("/map") public String coursemap() { return "trip/map"; }
    @GetMapping("/info") public String tourList() { return "tourInfo/tourInfo"; }
}

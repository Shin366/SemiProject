package com.fortrip.com.app.journey.trip.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fortrip.com.app.journey.trip.dto.TripRequest;
import com.fortrip.com.app.journey.trip.dto.TripView;
import com.fortrip.com.domain.journey.trip.model.service.TripService;

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
        return "trip/course"; // /WEB-INF/views/trip/course.jsp
    }

    // 상세
    @GetMapping("/course/{id}")
    public String courseDetail(@PathVariable int id, Model model) {
        TripView course = tripService.findTrip(id);
        model.addAttribute("course", course);
        return "trip/coursedetail";
    }
}

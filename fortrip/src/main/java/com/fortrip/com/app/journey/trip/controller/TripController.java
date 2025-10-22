package com.fortrip.com.app.journey.trip.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fortrip.com.app.journey.trip.dto.TripRequest;
import com.fortrip.com.domain.journey.trip.model.service.TripService;
import com.fortrip.com.domain.journey.trip.model.vo.Trip;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/trip")
@RequiredArgsConstructor
public class TripController {
	
	private final TripService tService;
	
	@GetMapping("/course")
	public String showCourseView(Model model) {

        return "trip/course"; // /WEB-INF/views/trip/course.jsp (ViewResolver 규칙에 따름)
	}
	
}

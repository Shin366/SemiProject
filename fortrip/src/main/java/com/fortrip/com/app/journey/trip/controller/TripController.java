package com.fortrip.com.app.journey.trip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fortrip.com.domain.journey.trip.model.service.TripService;

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

package com.fortrip.com.app.journey.roadmap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/roadmap")
public class RoadMapController {
	
	@GetMapping("/my")
	public String showMyView(Model model) {
	    return "/myroad/roadMain";
	}
}
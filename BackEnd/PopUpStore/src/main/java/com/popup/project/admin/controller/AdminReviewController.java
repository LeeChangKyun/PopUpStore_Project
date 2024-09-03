package com.popup.project.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Admin")
public class AdminReviewController {
	
	@GetMapping("/reviewList")
    public String reviewList() {
    	return "Admin/review/reviewList";
    }
	
}

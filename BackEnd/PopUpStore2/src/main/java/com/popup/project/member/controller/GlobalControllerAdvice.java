package com.popup.project.member.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.popup.project.member.auth.CustomUserDetails;
import com.popup.project.member.dto.CustomOAuth2User;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalControllerAdvice {

	@ModelAttribute
	public void addUserDetailsToModel(Model model, HttpSession session) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication != null) {
	        Object principal = authentication.getPrincipal();
	        
	        if (principal instanceof CustomUserDetails) {
	            CustomUserDetails userDetails = (CustomUserDetails) principal;
	            
	            // 일반 사용자 정보 설정
	            setModelAndSessionAttributes(model, session, userDetails.getUser().getUserId(), 
	                                          userDetails.getUser().getUserNick(), userDetails.getUser().getUserName(), 
	                                          userDetails.getUser().getUserEmail(), userDetails.getUser().getUserPhone(),
	                                          userDetails.getUser().getSocialId(), userDetails.getUser().getSocialProvider());
	            
	        } else if (principal instanceof CustomOAuth2User) {
	            CustomOAuth2User oAuth2User = (CustomOAuth2User) principal;

	            // 소셜 로그인 사용자 정보 설정
	            setModelAndSessionAttributes(model, session, oAuth2User.getAttribute("email"),
	                                          oAuth2User.getName(), "Social User", 
	                                          oAuth2User.getAttribute("email"), null,
	                                          oAuth2User.getAttribute("id"), oAuth2User.getAttribute("provider"));
	        }
	    }
	}

	private void setModelAndSessionAttributes(Model model, HttpSession session, String userId, String userNick, 
	                                          String userName, String userEmail, String userPhone, String socialId, String socialProvider) {
	    model.addAttribute("userId", userId);
	    model.addAttribute("userNick", userNick);
	    model.addAttribute("userName", userName);
	    model.addAttribute("userEmail", userEmail);
	    model.addAttribute("userPhone", userPhone);

	    session.setAttribute("userId", userId);
	    session.setAttribute("userNick", userNick);
	    session.setAttribute("userName", userName);
	    session.setAttribute("userEmail", userEmail);
	    session.setAttribute("userPhone", userPhone);

	    if (socialId != null) {
	        model.addAttribute("socialId", socialId);
	        session.setAttribute("socialId", socialId);
	    }

	    if (socialProvider != null) {
	        model.addAttribute("socialProvider", socialProvider);
	        session.setAttribute("socialProvider", socialProvider);
	    }
	}
    
}

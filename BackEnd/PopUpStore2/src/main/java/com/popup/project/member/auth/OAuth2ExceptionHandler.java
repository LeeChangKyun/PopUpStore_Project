package com.popup.project.member.auth;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import jakarta.servlet.http.HttpServletResponse;

@ControllerAdvice
public class OAuth2ExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public String handleOAuth2Redirect(RuntimeException ex, HttpServletResponse response) {
        if ("REDIRECT_TO_SOCIAL_FORM".equals(ex.getMessage())) {
            return "redirect:/SocialForm";
        }
        throw ex; // 다른 예외는 그대로 처리
    }
}
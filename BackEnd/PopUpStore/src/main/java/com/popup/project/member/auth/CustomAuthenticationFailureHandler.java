package com.popup.project.member.auth;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Autowired
    @Lazy
    private UserService userService;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
    	
        String username = request.getParameter("userName");
        UserDTO user = userService.getUserByUsername(username);
        String redirectUrl = "/Guest/auth/Login?error=true";
        
        if (user != null) {
            // 관리자인 경우 파라미터 추가
            if ("ROLE_ADMIN".equals(userService.getUserAuthority(user.getUserId()))) {
                redirectUrl += "&admin=true";
            } else {
                // 관리자가 아닌 경우 실패 횟수 증가
                userService.increaseFailedAttempts(user, response);
            }

            // 계정이 잠겨 있을 때
            if (user.isAccountLocked()) {
                if (!response.isCommitted()) {
                    // 로그 추가하여 상태 확인
                    System.out.println("계정이 잠김 상태입니다. 리다이렉트 URL에 locked 파라미터를 추가합니다.");
                    userService.lockAccount(user.getUserId());
                    redirectUrl = "/Member/auth/AccountAuth?locked=true";  // 잠김 상태일 때 리다이렉트 URL 설정
                    response.sendRedirect(redirectUrl);  // 리다이렉트
                    return;  // 리다이렉트 후 추가 처리 중단
                }
            }
        }

        // 로그인 실패로 인해 로그인 페이지로 리다이렉트
        if (!response.isCommitted()) {
            response.sendRedirect(redirectUrl);
        }
    }
}

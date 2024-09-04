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
        }

        // 리다이렉트하기 전에 응답이 이미 커밋되었는지 확인
        if (!response.isCommitted()) {
            response.sendRedirect(redirectUrl);
        } else {
            // 커밋되었을 경우, 오류 로그 출력
            System.out.println("응답이 이미 커밋되었습니다. 리다이렉트할 수 없습니다.");
        }
    }
}
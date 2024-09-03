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
    private UserService userService;  // UserServiceImpl 주입 시 @Lazy 사용

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        String username = request.getParameter("userName");

        UserDTO user = userService.getUserByUsername(username);

        if (user != null) {
            if (user.isEnabled() && !"ROLE_ADMIN".equals(userService.getUserAuthority(user.getUserId()))) {
                userService.increaseFailedAttempts(user);
            }

            if (user.getFailedAttempts() >= 5) {
                userService.lockAccount(user.getUserId());
            }
        }

        response.sendRedirect("/Guest/auth/Login?error=true");
    }
}
package com.popup.project.member.auth;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class RedirectAuthenticatedUserFilter extends OncePerRequestFilter {

	@Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated()) {
            boolean isAdmin = authentication.getAuthorities().stream()
                    .anyMatch(authority -> authority.equals(new SimpleGrantedAuthority("ROLE_ADMIN")));

            String requestURI = request.getRequestURI();

            // Admin 사용자가 "/" 경로로 접근할 경우 /Admin/Home으로 리디렉트
            if (isAdmin && requestURI.equals("/")) {
                response.sendRedirect("/Admin/Home");
                return;
            }

            // 로그인 페이지에 접근할 경우에도 동일하게 처리
            if (requestURI.equals("/Guest/auth/Login")) {
                if (isAdmin) {
                    response.sendRedirect("/Admin/Home?adminLogin=true");
                } else {
                    response.sendRedirect("/");
                }
                return;
            }
        }

        filterChain.doFilter(request, response);
    }
}

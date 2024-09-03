package com.popup.project.member.auth;

import java.io.IOException;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
public class MyAuthFailureHandler 
        implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(
            HttpServletRequest request, 
            HttpServletResponse response,
            AuthenticationException exception) 
                    throws IOException, ServletException {
        
        String errorMsg = "";
        
        if (exception instanceof BadCredentialsException) {
            loginFailureCnt(request.getParameter("userId"));
            errorMsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } 
        else if (exception instanceof InternalAuthenticationServiceException) {
            loginFailureCnt(request.getParameter("userId"));
            errorMsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } 
        else if (exception instanceof DisabledException) {
            errorMsg = "계정이 비활성화되었습니다. 관리자에게 문의하세요.";
        } 
        else if (exception instanceof CredentialsExpiredException) {
            errorMsg = "비밀번호 유효기간이 만료 되었습니다. 관리자에게 문의하세요.";
        }
        
        // errorMsg를 URL 파라미터로 전달
        response.sendRedirect("/Guest/Login?error=true&message=" + java.net.URLEncoder.encode(errorMsg, "UTF-8"));
    }
    
    public void loginFailureCnt(String username) {
        System.out.println("요청 아이디:" + username);
        // 여기에 틀린 횟수 업데이트 로직을 추가합니다.
    }
}
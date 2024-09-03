package com.popup.project.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.popup.project.member.auth.CustomUserDetails;
import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.dto.UserMapper;
import com.popup.project.member.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    BCryptPasswordEncoder pwEncoder;

    @RequestMapping("/Guest/auth/Login")
    public String signupLogin() {
        return "/Guest/auth/Login";
    }

    @PostMapping("/Login")
    public String processLogin(
            @RequestParam("username") String userName,
            @RequestParam("userpwd") String userPwd,
            HttpSession session,
            Model model) {

        UserDTO user = userService.getUserByUsername(userName);
        if (user == null) {
            model.addAttribute("errorMessage", "로그인 실패: 잘못된 사용자 이름 또는 비밀번호입니다.");
            return "/Guest/auth/Login";
        }

        if (pwEncoder.matches(userPwd, user.getUserPwd())) {
            CustomUserDetails userDetails = new CustomUserDetails(user);
            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);

            // 관리자일 경우
            if ("Admin".equals(user.getUserId())) {
                return "redirect:/Admin/Home?adminLogin=true";
            } else {
                return "redirect:/";
            }
        } else {
            model.addAttribute("errorMessage", "로그인 실패: 잘못된 사용자 이름 또는 비밀번호입니다.");
            return "/Guest/auth/Login";
        }
    }
    
}
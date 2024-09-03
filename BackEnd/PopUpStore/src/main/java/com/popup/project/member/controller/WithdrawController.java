package com.popup.project.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.popup.project.member.mapper.UserMapper;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Member/profile")
public class WithdrawController {

    @Autowired
    UserMapper userMapper;
    
    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    
    @GetMapping("/Withdraw")
    public String showWithdrawPage(@RequestParam("userId") String userId, Model model) {
        model.addAttribute("userId", userId);
        return "Member/profile/Withdraw"; 
    }

    @PostMapping("/Withdraw")
    public String withdrawUser(
            @RequestParam("userId") String userId,
            @RequestParam("userPwd") String userPwd, // 비밀번호는 일반 회원의 경우 필수
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // 비밀번호 검증 로직
        String storedPassword = userMapper.getPasswordByUserId(userId);

        if (storedPassword == null || !passwordEncoder.matches(userPwd, storedPassword)) {
            redirectAttributes.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            return "redirect:/Member/profile/Withdraw?userId=" + userId;
        }

        // 회원 탈퇴 처리
        int result = userMapper.deleteUserById(userId);

        if (result > 0) {
            session.invalidate(); // 세션 무효화
            redirectAttributes.addFlashAttribute("successMessage", "회원 탈퇴가 완료되었습니다 ㅜㅜ");
            return "redirect:/";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "회원 탈퇴에 실패했습니다.");
            return "redirect:/Member/profile/Withdraw?userId=" + userId;
        }
    }
    
    
    @PostMapping("/SocialWithdraw")
    public String withdrawSocialUser(
            @RequestParam("userId") String userId,
            @RequestParam("socialProvider") String socialProvider,  // socialProvider 파라미터 추가
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // 소셜 회원 탈퇴 처리
        int result = userMapper.deleteUserById(userId);

        if (result > 0) {
            session.invalidate(); // 세션 무효화
            redirectAttributes.addFlashAttribute("successMessage", "소셜 회원 탈퇴가 완료되었습니다 ㅜㅜ");
            return "redirect:/";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "소셜 회원 탈퇴에 실패했습니다.");
            return "redirect:/Member/profile/SocialEdit?userId=" + userId;
        }
    }
    
    
}

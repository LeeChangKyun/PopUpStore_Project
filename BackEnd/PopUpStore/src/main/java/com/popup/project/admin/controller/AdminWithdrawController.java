package com.popup.project.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.dto.UserMapper;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Admin/profile")
public class AdminWithdrawController {

    @Autowired
    UserMapper userMapper;
    
    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    
    @GetMapping("/search")
    public String searchUsers(@RequestParam("query") String query, Model model) {
        List<UserDTO> users = userMapper.searchUsersByIdOrNickname(query);
        if (users == null || users.isEmpty()) {
            model.addAttribute("message", "No users found.");
        } else {
            model.addAttribute("users", users);
        }
        return "Admin/UserList";  // JSP 파일 경로가 정확한지 확인하세요
    }
    
    @GetMapping("/Withdraw")
    public String showWithdrawPage(@RequestParam("userId") String userId, Model model) {
        model.addAttribute("userId", userId);
        return "Admin/profile/AdminWithdraw";  // JSP 파일 경로에 맞게 수정
    }

    @PostMapping("/Withdraw")
    public String withdrawUser(
            @RequestParam("userId") String userId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        int result = userMapper.deleteUserById(userId);
        
        if (result > 0) {
            redirectAttributes.addFlashAttribute("successMessage", "삭제되었습니다.");
            return "redirect:/Admin/users";  // 삭제 후 목록으로 리다이렉트
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "삭제에 실패했습니다.");
            return "redirect:/Admin/users";  // 실패 시 목록으로 리다이렉트
        }
    }
}

package com.popup.project.admin.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.service.UserService;

@Controller
@RequestMapping("/Admin")
public class AdminController {
	
	@Autowired
    private UserService userService;
	
    @GetMapping("/Home")
    public String adminHome() {
        return "Admin/Home";  // Admin 폴더 아래 Home.jsp로 매핑
    }
    
    @GetMapping("/UserList")
    public String userList() {
    	return "Admin/UserList";
    }
    
    @GetMapping("/AdminEdit")
    public String profileEdit() {
    	return "Admin/profile/AdminEdit";
    }
    
    @GetMapping("/Map")
    public String Map() {
    	return "Admin/Map";
    }
    
    @GetMapping("/users")
    public String listAllUsers(Model model) {
        List<UserDTO> users = userService.AdmingetAllUsers();
        
        // 관리자를 먼저 배열한 다음, 나머지 사용자들을 가입일자 기준으로 오름차순 정렬
        Collections.sort(users, new Comparator<UserDTO>() {
            @Override
            public int compare(UserDTO u1, UserDTO u2) {
                if (u1.getUserId().equals("Admin")) {
                    return -1; // u1이 Admin이면 앞으로
                } else if (u2.getUserId().equals("Admin")) {
                    return 1; // u2가 Admin이면 뒤로
                } else {
                    // 둘 다 Admin이 아닌 경우 가입일자 기준으로 정렬
                    return u1.getUserCreatedate().compareTo(u2.getUserCreatedate());
                }
            }
        });
        
        model.addAttribute("users", users);
        return "Admin/UserList";
    }
    
}
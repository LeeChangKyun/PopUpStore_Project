package com.popup.project.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.popup.project.member.auth.CustomUserDetails;
import com.popup.project.member.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {

    @Autowired
    UserService userService;

    @GetMapping("/")
    public String mainBody(Authentication authentication, Model model) {
        if (authentication != null && authentication.isAuthenticated()) {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            model.addAttribute("role", "MEMBER");
            model.addAttribute("userId", userDetails.getUser().getUserId());
        } else {
            model.addAttribute("role", "GUEST");
        }
        return "Home"; // /WEB-INF/views/Home.jsp로 이동
    }

    @RequestMapping("/Map")
    public String guestMap(Authentication authentication, Model model) {
        if (authentication != null && authentication.isAuthenticated()) {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            model.addAttribute("role", "MEMBER");
            model.addAttribute("userId", userDetails.getUser().getUserId());
        } else {
            model.addAttribute("role", "GUEST");
        }
        return "Map"; // /WEB-INF/views/Map.jsp로 이동
    }
    @RequestMapping("/GoodsShop")
    public String goodsShop(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        if (userDetails != null) {
            // 사용자 정보가 있는 경우
            model.addAttribute("role", "MEMBER");
            model.addAttribute("userId", userDetails.getUser().getUserId());
        } else {
            // 사용자 정보가 없는 경우
            model.addAttribute("role", "GUEST");
        }
        return "GoodsShop"; // /WEB-INF/views/GoodsShop.jsp로 이동
    }
    
    @RequestMapping("/Cart")
    public String Cart(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        if (userDetails != null) {
            // 사용자 정보가 있는 경우
            model.addAttribute("role", "MEMBER");
            model.addAttribute("userId", userDetails.getUser().getUserId());
        } else {
            // 사용자 정보가 없는 경우
            model.addAttribute("role", "GUEST");
        }
        return "Cart"; // /WEB-INF/views/Cart.jsp로 이동
    }
    
    @RequestMapping("/GoodsDetail")
    public String goodsDetail(Model model) {
        // 여기에 필요한 모델 속성 추가
        return "Detail/GoodsDetail";
    }
    
    @RequestMapping("/GoodsDetail2")
    public String goodsDetail2(Model model) {
        // 여기에 필요한 모델 속성 추가
        return "Detail/GoodsDetail2"; 
    }
    
    @RequestMapping("/GoodsDetail3")
    public String goodsDetail3(Model model) {
        // 여기에 필요한 모델 속성 추가
        return "Detail/GoodsDetail3"; 
    }
    
    @RequestMapping("/GoodsDetail4")
    public String goodsDetail4(Model model) {
        // 여기에 필요한 모델 속성 추가
        return "Detail/GoodsDetail4"; 
    }
    
    @RequestMapping("/GoodsDetail5")
    public String goodsDetail5(Model model) {
        // 여기에 필요한 모델 속성 추가
        return "Detail/GoodsDetail5"; 
    }
    
    @RequestMapping("/GoodsDetail6")
    public String goodsDetail6(Model model) {
        // 여기에 필요한 모델 속성 추가
        return "Detail/GoodsDetail6"; 
    }
    
    @RequestMapping("/PopupDetail")
    public String popupdetail(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        if (userDetails != null) {
            // 사용자 정보가 있는 경우
            model.addAttribute("role", "MEMBER");
            model.addAttribute("userId", userDetails.getUser().getUserId());
        } else {
            // 사용자 정보가 없는 경우
            model.addAttribute("role", "GUEST");
        }
        return "Detail/PopupDetail";
    }
    
    @RequestMapping("/PopupDetail2")
    public String popupdetail2(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        if (userDetails != null) {
            // 사용자 정보가 있는 경우
            model.addAttribute("role", "MEMBER");
            model.addAttribute("userId", userDetails.getUser().getUserId());
        } else {
            // 사용자 정보가 없는 경우
            model.addAttribute("role", "GUEST");
        }
        return "Detail/PopupDetail2"; 
    }
    
    @RequestMapping("/PopupDetail3")
    public String popupdetail3(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        if (userDetails != null) {
            // 사용자 정보가 있는 경우
            model.addAttribute("role", "MEMBER");
            model.addAttribute("userId", userDetails.getUser().getUserId());
        } else {
            // 사용자 정보가 없는 경우
            model.addAttribute("role", "GUEST");
        }
        return "Detail/PopupDetail3"; 
    }
    
    @RequestMapping("/PopupDetail4")
    public String popupdetail4(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        if (userDetails != null) {
            // 사용자 정보가 있는 경우
            model.addAttribute("role", "MEMBER");
            model.addAttribute("userId", userDetails.getUser().getUserId());
        } else {
            // 사용자 정보가 없는 경우
            model.addAttribute("role", "GUEST");
        }
        return "Detail/PopupDetail4"; 
    }
}


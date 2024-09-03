package com.popup.project.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.popup.project.member.auth.CustomUserDetails;
import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.dto.UserMapper;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("Member/profile")
public class EditController {

    @Autowired
    UserMapper userMapper;
    
    @Autowired
    BCryptPasswordEncoder pwEncoder;
    
    @RequestMapping("/Edit")
    public String edit(Model model, HttpSession session, Authentication authentication) {
        if (authentication == null || authentication.getPrincipal().equals("anonymousUser")) {
            System.out.println("Authentication이 null이거나 anonymousUser입니다.");
            return "redirect:/Guest/auth/Login";
        }

        Object principal = authentication.getPrincipal();
        System.out.println("Principal 클래스: " + principal.getClass().getName());

        if (!(principal instanceof CustomUserDetails)) {
            System.out.println("Principal이 CustomUserDetails가 아닙니다.");
            return "redirect:/Guest/auth/Login";
        }

        CustomUserDetails userDetails = (CustomUserDetails) principal;
        String userId = userDetails.getUsername();
        System.out.println("User ID: " + userId);

        // 소셜 회원인지 확인
        String socialProvider = userDetails.getUser().getSocialProvider();
        if (socialProvider != null && !socialProvider.isEmpty()) {
            // 소셜 회원은 SocialEdit 페이지로 리디렉션
            return "redirect:/Member/profile/SocialEdit";
        }

        // 관리자 여부 확인
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(role -> role.getAuthority().equals("ROLE_ADMIN"));

        if (isAdmin) {
            // 관리자는 관리자 페이지로 리디렉션
            return "redirect:/Admin/profile/Edit";
        }

        // 일반 회원의 경우
        model.addAttribute("userId", userId);
        return "/Member/profile/Edit";
    }
    
    @GetMapping("/SocialEdit")
    public String socialEdit(Model model, HttpSession session, Authentication authentication) {
        if (authentication == null || authentication.getPrincipal().equals("anonymousUser")) {
            System.out.println("Authentication이 null이거나 anonymousUser입니다.");
            return "redirect:/Guest/auth/Login";
        }

        Object principal = authentication.getPrincipal();
        if (!(principal instanceof CustomUserDetails)) {
            System.out.println("Principal이 CustomUserDetails가 아닙니다.");
            return "redirect:/Guest/auth/Login";
        }

        CustomUserDetails userDetails = (CustomUserDetails) principal;
        String userId = userDetails.getUsername();
        System.out.println("User ID: " + userId);

        // 소셜 회원 정보 가져오기
        UserDTO user = userMapper.getUserByUsername(userId);
        if (user == null) {
            System.out.println("해당 사용자를 찾을 수 없습니다.");
            return "redirect:/Guest/auth/Login";
        }

        model.addAttribute("user", user);
        return "/Member/profile/SocialEdit";  // 소셜 회원의 정보 수정 페이지로 이동
    }
    
    
    
    @PostMapping("/Update")
    public String updateUser(
            @RequestParam("userId") String userId,
            @RequestParam(value = "currentPwd", required = false, defaultValue = "") String currentPwd,  
            @RequestParam(value = "userNick", required = false, defaultValue = "") String userNick,
            @RequestParam(value = "userPhone", required = false, defaultValue = "") String userPhone,
            @RequestParam(value = "userEmail", required = false, defaultValue = "") String userEmail,
            @RequestParam(value = "userZipcode", required = false, defaultValue = "") String userZipcode,
            @RequestParam(value = "userAddress", required = false, defaultValue = "") String userAddress,
            @RequestParam(value = "userPwd", required = false, defaultValue = "") String userPwd,  
            Model model, RedirectAttributes redirectAttributes, Authentication authentication, HttpSession session) {

        try {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

            UserDTO user = new UserDTO();
            user.setUserId(userId);

            if (userDetails.getUser().getSocialId() != null) {
                currentPwd = "";
                userPwd = "";
            } else {
                String dbPwd = userMapper.getPasswordByUserId(userId);

                if (dbPwd == null || !pwEncoder.matches(currentPwd.trim(), dbPwd)) {
                    redirectAttributes.addFlashAttribute("errorMessage", "현재 비밀번호가 일치하지 않습니다.");
                    return "redirect:/Member/profile/Edit";
                }

                if (!userPwd.isEmpty()) {
                    if (userPwd.length() < 8 || userPwd.length() > 20) {
                        redirectAttributes.addFlashAttribute("errorMessage", "비밀번호는 8자리 이상 20자리 이하로 입력해주세요.");
                        return "redirect:/Member/profile/Edit";
                    }
                    String encryptedPassword = pwEncoder.encode(userPwd);
                    user.setUserPwd(encryptedPassword);
                }
            }

            if (!userNick.isEmpty() && !userNick.equals(userDetails.getUser().getUserNick())) {
                if (userMapper.NickCheck(userNick) > 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "중복된 닉네임이 있습니다.");
                    return "redirect:/Member/profile/Edit";
                }
                user.setUserNick(userNick);
                session.setAttribute("userNick", userNick);
                model.addAttribute("userNick", userNick);
                userDetails.getUser().setUserNick(userNick); // 사용자 정보도 업데이트
            }

            if (!userPhone.isEmpty() && !userPhone.equals(userDetails.getUser().getUserPhone())) {
                if (userMapper.PhoneCheck(userPhone) > 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "중복된 전화번호가 있습니다.");
                    return "redirect:/Member/profile/Edit";
                }
                user.setUserPhone(userPhone);
                session.setAttribute("userPhone", userPhone);
                model.addAttribute("userPhone", userPhone);
                userDetails.getUser().setUserPhone(userPhone); // 사용자 정보도 업데이트
            }

            if (!userEmail.isEmpty() && !userEmail.equals(userDetails.getUser().getUserEmail())) {
                if (userMapper.EmailCheck(userEmail) > 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "중복된 이메일이 있습니다.");
                    return "redirect:/Member/profile/Edit";
                }
                user.setUserEmail(userEmail);
                session.setAttribute("userEmail", userEmail);
                model.addAttribute("userEmail", userEmail);
                userDetails.getUser().setUserEmail(userEmail); // 사용자 정보도 업데이트
            }

            if (!userZipcode.isEmpty() && !userZipcode.equals(userDetails.getUser().getUserZipcode())) {
                user.setUserZipcode(userZipcode);
                session.setAttribute("userZipcode", userZipcode);
                model.addAttribute("userZipcode", userZipcode);
                userDetails.getUser().setUserZipcode(userZipcode); // 사용자 정보도 업데이트
            }

            if (!userAddress.isEmpty() && !userAddress.equals(userDetails.getUser().getUserAddress())) {
                user.setUserAddress(userAddress);
                session.setAttribute("userAddress", userAddress);
                model.addAttribute("userAddress", userAddress);
                userDetails.getUser().setUserAddress(userAddress); // 사용자 정보도 업데이트
            }

            int result = userMapper.updateUserInfo(user);

            if (result > 0) {
                redirectAttributes.addFlashAttribute("successMessage", "정보수정이 완료되었습니다!");
                return "redirect:/";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "정보수정에 실패하였습니다!");
                return "redirect:/Member/profile/Edit";
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
            return "redirect:/Member/profile/Edit";
        }
    }
    
    
    @PostMapping("/SocialUpdate")
    public String updateSocialUser(
            @RequestParam("userNick") String userNick,
            @RequestParam("userName") String userName,
            @RequestParam("userPhone") String userPhone,
            @RequestParam("userZipcode") String userZipcode,
            @RequestParam("userAddress") String userAddress,
            Model model, RedirectAttributes redirectAttributes, HttpSession session, Authentication authentication) {

        try {
            // 현재 인증된 사용자 정보 가져오기
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            String userId = userDetails.getUsername();

            // 사용자 DTO 생성 및 설정
            UserDTO user = new UserDTO();
            user.setUserId(userId);

            // 닉네임 업데이트 로직
            if (!userNick.isEmpty() && !userNick.equals(userDetails.getUser().getUserNick())) {
                if (userMapper.NickCheck(userNick) > 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "중복된 닉네임이 있습니다.");
                    return "redirect:/Member/profile/SocialEdit";
                }
                user.setUserNick(userNick);
                session.setAttribute("userNick", userNick);
                model.addAttribute("userNick", userNick);
                userDetails.getUser().setUserNick(userNick);
            }

            // 전화번호 업데이트 로직
            if (!userPhone.isEmpty() && !userPhone.equals(userDetails.getUser().getUserPhone())) {
                if (userMapper.PhoneCheck(userPhone) > 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "중복된 전화번호가 있습니다.");
                    return "redirect:/Member/profile/SocialEdit";
                }
                user.setUserPhone(userPhone);
                session.setAttribute("userPhone", userPhone);
                model.addAttribute("userPhone", userPhone);
                userDetails.getUser().setUserPhone(userPhone);
            }

            // 이메일 업데이트 로직
            if (!userName.isEmpty() && !userName.equals(userDetails.getUser().getUserName())) {
                if (userMapper.EmailCheck(userName) > 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "중복된 이메일이 있습니다.");
                    return "redirect:/Member/profile/SocialEdit";
                }
                user.setUserName(userName);
                session.setAttribute("userName", userName);
                model.addAttribute("userName", userName);
                userDetails.getUser().setUserName(userName);
            }

            // 우편번호 업데이트 로직
            if (!userZipcode.isEmpty()) {
                user.setUserZipcode(userZipcode);
                session.setAttribute("userZipcode", userZipcode);
                model.addAttribute("userZipcode", userZipcode);
                userDetails.getUser().setUserZipcode(userZipcode);
            }

            // 주소 업데이트 로직
            if (!userAddress.isEmpty()) {
                user.setUserAddress(userAddress);
                session.setAttribute("userAddress", userAddress);
                model.addAttribute("userAddress", userAddress);
                userDetails.getUser().setUserAddress(userAddress);
            }

            // 사용자 정보 업데이트
            int result = userMapper.updateUserInfo(user);

            if (result > 0) {
                redirectAttributes.addFlashAttribute("successMessage", "정보수정이 완료되었습니다!");
                return "redirect:/Member/profile/SocialEdit";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "정보수정에 실패하였습니다!");
                return "redirect:/Member/profile/SocialEdit";
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
            return "redirect:/Member/profile/SocialEdit";
        }
    }
    
    
    
}

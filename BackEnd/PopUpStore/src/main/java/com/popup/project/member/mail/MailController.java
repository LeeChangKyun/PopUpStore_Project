package com.popup.project.member.mail;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.popup.project.member.service.UserService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MailController {

    private final MailService mailService;
    private final UserService userService;

    @PostMapping("/emailCheck")
    public ResponseEntity<Map<String, Boolean>> emailCheck(@RequestBody MailDTO mailDTO, HttpSession session) {
        boolean match = userService.checkUserNameAndEmail(mailDTO.getName(), mailDTO.getEmail());
        Map<String, Boolean> response = new HashMap<>();
        response.put("match", match);

        if (match) {
            session.setAttribute("email", mailDTO.getEmail());
            mailService.sendSimpleMessageAsync(mailDTO.getEmail(), session);
        }

        return ResponseEntity.ok(response);
    }

    @PostMapping("/verifyAuthCode")
    public ResponseEntity<Map<String, Boolean>> verifyAuthCode(@RequestBody Map<String, String> request, HttpSession session) throws MessagingException {
        System.out.println("verifyAuthCode method start.");

        String authCode = request.get("authCode");
        System.out.println("Auth Code received: " + authCode);

        String savedAuthCode = (String) session.getAttribute("authNumber");
        String email = (String) session.getAttribute("email");
        System.out.println("Saved Auth Code: " + savedAuthCode);
        System.out.println("Email in session: " + email);

        if (email == null || email.isEmpty()) {
            throw new IllegalArgumentException("유효한 이메일 주소가 필요합니다.");
        }

        Map<String, Boolean> response = new HashMap<>();

        if (savedAuthCode != null && savedAuthCode.trim().equals(authCode)) {
            response.put("verified", true);
            session.removeAttribute("authNumber");
            System.out.println("Auth code verified, sending temp password.");
            System.out.println("Calling sendTempPasswordAsync for email: " + email);
            mailService.sendTempPasswordAsync(email, session, userService);
            System.out.println("Async call made for sending temp password.");
        } else {
            response.put("verified", false);
            System.out.println("Auth code verification failed.");
        }

        System.out.println("Preparing to send response.");
        return ResponseEntity.ok(response);
        
    }
}
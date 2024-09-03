package com.popup.project.member.mail;

import java.util.Random;

import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.popup.project.member.service.UserService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailService {

    private final JavaMailSender javaMailSender;
    private static final String senderEmail = "lckdrbs@gmail.com";

    public String createNumber() {
        Random random = new Random();
        StringBuilder key = new StringBuilder();

        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(3);

            switch (index) {
                case 0 -> key.append((char) (random.nextInt(26) + 97)); // 소문자
                case 1 -> key.append((char) (random.nextInt(26) + 65)); // 대문자
                case 2 -> key.append(random.nextInt(10)); // 숫자
            }
        }
        return key.toString();
    }

    public MimeMessage createAuthCodeMail(String mail, String authCode) throws MessagingException {
        MimeMessage message = javaMailSender.createMimeMessage();

        message.setFrom(senderEmail);
        message.setRecipients(MimeMessage.RecipientType.TO, mail);
        message.setSubject("이메일 인증");
        String body = "<h4>인증번호는</h4><h1>" + authCode + "</h1><h4>입니다<h4>";
        message.setText(body, "UTF-8", "html");

        return message;
    }

    public MimeMessage createTempPasswordMail(String mail, String tempPassword) throws MessagingException {
        MimeMessage message = javaMailSender.createMimeMessage();

        message.setFrom(senderEmail);
        message.setRecipients(MimeMessage.RecipientType.TO, mail);
        message.setSubject("임시 비밀번호 안내");
        // 이메일 본문에 멘트와 함께 임시 비밀번호 포함
        String body = "<h4>안녕하세요,</h4>";
        body += "<p>임시 비밀번호는 <strong>" + tempPassword + "</strong> 입니다.</p>";
        body += "<p>로그인 후 비밀번호를 변경해 주세요.</p>";
        body += "<p>감사합니다.</p>";
        
        message.setText(body, "UTF-8", "html");

        return message;
    }
    
    @Async
    public void sendSimpleMessageAsync(String sendEmail, HttpSession session) {
        try {
            String authCode = createNumber(); // 랜덤 인증번호 생성
            session.setAttribute("authNumber", authCode); // 인증번호를 세션에 저장
            MimeMessage message = createAuthCodeMail(sendEmail, authCode); // 인증번호 메일 생성
            javaMailSender.send(message); // 메일 발송
            System.out.println("Email sent successfully to: " + sendEmail);
        } catch (MailException | MessagingException e) {
            System.err.println("Failed to send email to " + sendEmail);
            e.printStackTrace();
            throw new IllegalArgumentException("메일 발송 중 오류가 발생했습니다.");
        }
    }

    @Async
    public void sendTempPasswordAsync(String sendEmail, HttpSession session, UserService userService) {
        try {
            String tempPassword = createNumber(); 
            userService.updatePasswordByEmail(sendEmail, tempPassword); // 사용자 비밀번호 업데이트
            System.out.println("Password update completed, preparing to send email.");
            session.setAttribute("tempPassword", tempPassword); // 임시 비밀번호를 세션에 저장
            MimeMessage message = createTempPasswordMail(sendEmail, tempPassword); // 임시 비밀번호 메일 생성
            javaMailSender.send(message); // 메일 발송
            System.out.println("Temporary password email sent successfully to: " + sendEmail);
        } catch (MailException | MessagingException e) {
            System.err.println("Failed to send temporary password email to " + sendEmail);
            e.printStackTrace();  // 이 부분에서 예외 메시지 확인
        } catch (Exception ex) {
            System.err.println("Unexpected error occurred while sending temporary password email: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
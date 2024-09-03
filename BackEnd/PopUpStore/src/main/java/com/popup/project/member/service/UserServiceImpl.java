package com.popup.project.member.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.mail.MailService;
import com.popup.project.member.mapper.UserMapper;

import jakarta.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private BCryptPasswordEncoder pwEncoder;
    
    @Autowired
    private MailService mailService;
    
    @Override
    public UserDTO getUserByUsername(String username) {
        return userMapper.getUserByUsername(username);
    }

    public UserServiceImpl() {
        pwEncoder = new BCryptPasswordEncoder();
    }

    @Override
    public int IdCheck(String id) {
        return userMapper.IdCheck(id);
    }

    @Override
    public int NickCheck(String nick) {
        return userMapper.NickCheck(nick);
    }

    @Override
    public int EmailCheck(String email) {
        return userMapper.EmailCheck(email);
    }

    @Override
    public int PhoneCheck(String phone) {
        return userMapper.PhoneCheck(phone);
    }

    @Override
    public String FindId(String name, String phone) {
        return userMapper.FindId(name, phone);
    }

    @Override
    public boolean checkUserNameAndEmail(String userName, String userEmail) {
        int count = userMapper.checkUserNameAndEmail(userName, userEmail);
        return count > 0; // 아이디와 이메일이 일치하는 경우 true 반환
    }

    @Transactional
    public void handlePasswordReset(String email, HttpSession session) {
        // 트랜잭션 내에서 비밀번호 업데이트
        String tempPassword = generateTempPassword();
        updatePasswordByEmail(email, tempPassword);

        // 비동기 메서드에서 메일 발송 처리
        mailService.sendTempPasswordAsync(email, session, this); // 비밀번호 전달 필요
    }

    private String generateTempPassword() {
        // MailService의 createNumber 메서드를 사용하여 임시 비밀번호 생성
        return mailService.createNumber();
    }

    @Override
    @Transactional
    public void updatePasswordByEmail(@Param("email") String email, @Param("password") String password) {
        try {
            String encryptedPassword = pwEncoder.encode(password);
            int rowsAffected = userMapper.updatePasswordByEmail(email, encryptedPassword);
            if (rowsAffected > 0) {
                System.out.println("Password updated in the database for email: " + email);
            } else {
                System.err.println("Failed to update password in the database for email: " + email);
                throw new RuntimeException("Password update failed");
            }
        } catch (Exception e) {
            System.err.println("Exception occurred while updating password: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    @Transactional
    public int register(UserDTO dto) {
        // 아이디 중복 체크
        int idCheckResult = userMapper.IdCheck(dto.getUserId());
        if (idCheckResult > 0) {
            return -1;
        }
        int NickCheckResult = userMapper.NickCheck(dto.getUserNick());
        if (NickCheckResult > 0) {
            return -2;
        }
        int EmailCheckResult = userMapper.EmailCheck(dto.getUserEmail());
        if (EmailCheckResult > 0) {
            return -3;
        }

        String securePwd = pwEncoder.encode(dto.getUserPwd());
        dto.setUserPwd(securePwd);

        int result = 0;

        try {
            result = userMapper.register(dto);
            System.out.println("회원가입에 성공했습니다: " + dto.getUserId());
        } catch (Exception e) {
            System.err.println("회원가입에 실패했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public List<UserDTO> AdmingetAllUsers() {
        List<UserDTO> users = userMapper.AdmingetAllUsers();
        System.out.println("Users from MyBatis: " + users);
        return users;
    }

    // 2. 소셜 로그인 사용자 등록 메서드 추가
    @Override
    @Transactional
    public void registerSocialUser(UserDTO user) {
        try {
            // 소셜 로그인 사용자를 DB에 저장
            userMapper.saveSocialUser(user);
            System.out.println("소셜 로그인 사용자 등록 성공: " + user.getUserId());
        } catch (Exception e) {
            System.err.println("소셜 로그인 사용자 등록 실패: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("소셜 로그인 사용자 등록 중 오류 발생");
        }
    }
    
    // 로그인 실패 시도 증가
    @Override
    @Transactional
    public void increaseFailedAttempts(UserDTO user) {
        if ("ROLE_ADMIN".equals(userMapper.getUserAuthority(user.getUserId()))) {
            return; // Admin은 실패 횟수 증가하지 않음
        }
        
        // 실패 횟수를 강제로 다시 가져옴
        int currentFailedAttempts = userMapper.getFailedAttempts(user.getUserId());
        System.out.println("Current failed attempts for user " + user.getUserId() + ": " + currentFailedAttempts);
        
        // 새로운 실패 횟수 계산
        int newFailAttempts = currentFailedAttempts + 1;
        System.out.println("Failed attempts for user " + user.getUserId() + ": " + newFailAttempts);
        
        // 실패 횟수 업데이트
        userMapper.updateFailedAttempts(newFailAttempts, user.getUserId());
        
        // UserDTO 객체에 실패 횟수 반영
        user.setFailedAttempts(newFailAttempts);
        
        // 5회 이상 실패 시 계정 잠금
        if (newFailAttempts >= 5) {
            lockAccount(user.getUserId());
        }
    }

    @Override
    @Transactional
    public void resetFailedAttempts(String userId) {
        System.out.println("Resetting failed attempts for user " + userId);
        userMapper.updateFailedAttempts(0, userId);
    }

    // 계정 잠금
    @Override
    @Transactional
    public void lockAccount(String userId) {
        userMapper.lockAccount(userId);
    }

    // 계정 잠금 해제
    @Override
    @Transactional
    public void unlockAccount(String userId) {
        userMapper.unlockAccount(userId);
    }
    
    @Override
    public String getUserAuthority(@Param("userId") String userId) {
        return userMapper.getUserAuthority(userId);
    }
    
}
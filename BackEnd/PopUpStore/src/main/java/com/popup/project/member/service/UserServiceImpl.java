package com.popup.project.member.service;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.mail.MailService;
import com.popup.project.member.mapper.UserMapper;

import jakarta.servlet.http.HttpServletResponse;
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
    
    // 계정 잠금 상태 확인
    public boolean isAccountLocked(UserDTO user) {
        if (user.isAccountLocked()) {
            System.out.println("계정이 잠겨 있습니다.");
            return true;
        }
        return false;
    }

    // 실패 횟수 업데이트
    @Transactional
    public void updateFailedAttempts(int attempts, String userId) {
        System.out.println("Updating failed attempts for user " + userId + ": " + attempts);
        userMapper.updateFailedAttempts(attempts, userId);
    }

    // 실패 횟수 초기화
    @Override
    @Transactional
    public void resetFailedAttempts(String userId) {
        updateFailedAttempts(0, userId);
    }

    // 로그인 실패시도 증가
    @Override
    @Transactional
    public void increaseFailedAttempts(UserDTO user, HttpServletResponse response) throws IOException {
        if ("ROLE_ADMIN".equals(getUserAuthority(user.getUserId()))) {
            return; // 관리자는 실패 횟수 증가하지 않음
        }

        int currentFailedAttempts = userMapper.getFailedAttempts(user.getUserId());
        int newFailAttempts = currentFailedAttempts + 1;

        // 실패 횟수 업데이트
        updateFailedAttempts(newFailAttempts, user.getUserId());
        user.setFailedAttempts(newFailAttempts);

        // 5회 이상 실패 시 계정 잠금 후 리다이렉트
        if (newFailAttempts >= 5) {
            lockAccount(user.getUserId());

            // 응답이 커밋되지 않은 경우에만 리다이렉트 실행
            if (!response.isCommitted()) {
                response.sendRedirect("/Member/auth/AccountAuth");
                return;  // 리다이렉트 후 추가 로직 중단
            }
        }
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
        System.out.println("계정 잠금 해제 처리 중: " + userId);
        userMapper.unlockAccount(userId);
        System.out.println("계정 잠금 해제 완료: " + userId);
    }

    // 로그인 로직
    @Override
    @Transactional
    public boolean login(String userId, String password, HttpServletResponse response) {
        UserDTO user = userMapper.getUserByUsername(userId);

        if (user == null) {
            return false;
        }

        if (pwEncoder.matches(password, user.getUserPwd())) {

            if (isAccountLocked(user)) {
                return false; // 계정 잠김 상태일 경우 로그인 불가
            }

            resetFailedAttempts(userId);  // 실패 횟수 초기화
            unlockAccount(userId);        // 계정 잠금 해제

            return true; // 로그인 성공
        } else {
            try {
                increaseFailedAttempts(user, response);  // 실패 횟수 증가
            } catch (IOException e) {
                e.printStackTrace();
                // 필요한 경우 예외 처리 로직 추가 (예: 로그 기록, 사용자에게 오류 메시지 전달 등)
            }
            return false;
        }
    }
    
    @Override
    public String getUserAuthority(String userId) {
        return userMapper.getUserAuthority(userId); // 매퍼를 통해 DB에서 권한 조회
    }
    
    
    @Override
    @Transactional
    public void unlockAccountByEmailAndResetAttempts(String email) {
        userMapper.unlockAccountByEmail(email);  // 이메일로 계정 잠금 해제
     // 실패 시도 횟수 초기화
        userMapper.resetFailedAttemptsByEmail(email);  // 실패 시도 횟수 초기화
    }
    
}
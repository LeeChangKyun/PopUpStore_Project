package com.popup.project.member.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.dto.UserMapper;
import com.popup.project.member.mail.MailService;

import jakarta.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;
    
    @Autowired
    BCryptPasswordEncoder pwEncoder;
    
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
        // 입력값 검증
        if (user == null) {
            System.err.println("소셜 로그인 사용자 등록 실패: user 객체가 null임");
            throw new IllegalArgumentException("사용자 정보가 null입니다.");
        }
        if (user.getSocialId() == null || user.getSocialId().trim().isEmpty()) {
            System.err.println("소셜 로그인 사용자 등록 실패: socialId가 null이거나 비어있음");
            throw new IllegalArgumentException("소셜 로그인 ID가 비어있습니다.");
        }
        if (user.getSocialProvider() == null || user.getSocialProvider().trim().isEmpty()) {
            System.err.println("소셜 로그인 사용자 등록 실패: socialProvider가 null이거나 비어있음");
            throw new IllegalArgumentException("소셜 로그인 제공자가 비어있습니다.");
        }
        
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

    // 3. 소셜 로그인 사용자 조회 메서드 추가
    @Override
    public UserDTO findBySocialIdAndProvider(String socialId, String provider) {
        // 입력값 검증
        if (socialId == null || socialId.trim().isEmpty()) {
            System.err.println("소셜 로그인 사용자 조회 실패: socialId가 null이거나 비어있음");
            return null;
        }
        if (provider == null || provider.trim().isEmpty()) {
            System.err.println("소셜 로그인 사용자 조회 실패: provider가 null이거나 비어있음");
            return null;
        }
        
        try {
            UserDTO user = userMapper.findBySocialIdAndProvider(socialId, provider);
            System.out.println("소셜 로그인 사용자 조회: " + (user != null ? user.getUserId() : "없음"));
            return user;
        } catch (Exception e) {
            System.err.println("소셜 로그인 사용자 조회 실패: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // 4. 소셜 로그인 사용자 정보 업데이트 메서드 추가
    @Override
    @Transactional
    public int updateUserBySocialIdAndProvider(UserDTO user) {
        // 입력값 검증
        if (user == null) {
            System.err.println("소셜 로그인 사용자 정보 업데이트 실패: user 객체가 null임");
            throw new IllegalArgumentException("사용자 정보가 null입니다.");
        }
        if (user.getSocialId() == null || user.getSocialId().trim().isEmpty()) {
            System.err.println("소셜 로그인 사용자 정보 업데이트 실패: socialId가 null이거나 비어있음");
            throw new IllegalArgumentException("소셜 로그인 ID가 비어있습니다.");
        }
        if (user.getSocialProvider() == null || user.getSocialProvider().trim().isEmpty()) {
            System.err.println("소셜 로그인 사용자 정보 업데이트 실패: socialProvider가 null이거나 비어있음");
            throw new IllegalArgumentException("소셜 로그인 제공자가 비어있습니다.");
        }
        
        try {
            int result = userMapper.updateUserBySocialIdAndProvider(user);
            if (result > 0) {
                System.out.println("소셜 로그인 사용자 정보 업데이트 성공: " + user.getUserId());
            } else {
                System.err.println("소셜 로그인 사용자 정보 업데이트 실패: 사용자를 찾을 수 없음");
            }
            return result;
        } catch (Exception e) {
            System.err.println("소셜 로그인 사용자 정보 업데이트 실패: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("소셜 로그인 사용자 정보 업데이트 중 오류 발생");
        }
    }

    // 5. 일반 사용자 정보 업데이트 메서드 추가
    @Override
    @Transactional
    public int updateUserInfo(UserDTO user) {
        // 입력값 검증
        if (user == null) {
            System.err.println("사용자 정보 업데이트 실패: user 객체가 null임");
            throw new IllegalArgumentException("사용자 정보가 null입니다.");
        }
        if (user.getUserId() == null || user.getUserId().trim().isEmpty()) {
            System.err.println("사용자 정보 업데이트 실패: userId가 null이거나 비어있음");
            throw new IllegalArgumentException("사용자 ID가 비어있습니다.");
        }
        
        try {
            // 비밀번호가 입력된 경우에만 암호화
            if (user.getUserPwd() != null && !user.getUserPwd().trim().isEmpty()) {
                String encryptedPassword = pwEncoder.encode(user.getUserPwd());
                user.setUserPwd(encryptedPassword);
            }
            
            int result = userMapper.updateUserInfo(user);
            if (result > 0) {
                System.out.println("사용자 정보 업데이트 성공: " + user.getUserId());
            } else {
                System.err.println("사용자 정보 업데이트 실패: 사용자를 찾을 수 없음");
            }
            return result;
        } catch (Exception e) {
            System.err.println("사용자 정보 업데이트 실패: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("사용자 정보 업데이트 중 오류 발생");
        }
    }

    // 6. 사용자 삭제 메서드 추가
    @Override
    @Transactional
    public int deleteUserById(String userId) {
        // 입력값 검증
        if (userId == null || userId.trim().isEmpty()) {
            System.err.println("사용자 삭제 실패: userId가 null이거나 비어있음");
            throw new IllegalArgumentException("사용자 ID가 비어있습니다.");
        }
        
        try {
            int result = userMapper.deleteUserById(userId);
            if (result > 0) {
                System.out.println("사용자 삭제 성공: " + userId);
            } else {
                System.err.println("사용자 삭제 실패: 사용자를 찾을 수 없음");
            }
            return result;
        } catch (Exception e) {
            System.err.println("사용자 삭제 실패: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("사용자 삭제 중 오류 발생");
        }
    }

    // 7. 사용자 검색 메서드 추가 (관리자용)
    @Override
    public List<UserDTO> searchUsersByIdOrNickname(String query) {
        // 입력값 검증
        if (query == null || query.trim().isEmpty()) {
            System.err.println("사용자 검색 실패: 검색어가 null이거나 비어있음");
            return List.of(); // 빈 리스트 반환
        }
        
        try {
            List<UserDTO> users = userMapper.searchUsersByIdOrNickname(query);
            System.out.println("사용자 검색 결과: " + (users != null ? users.size() : 0) + "명");
            return users != null ? users : List.of();
        } catch (Exception e) {
            System.err.println("사용자 검색 실패: " + e.getMessage());
            e.printStackTrace();
            return List.of(); // 예외 발생 시 빈 리스트 반환
        }
    }
}
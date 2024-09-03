package com.popup.project.member.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.popup.project.member.dto.UserDTO;

public interface UserService {

    UserDTO getUserByUsername(String username);

    int IdCheck(@Param("userId") String userId);

    int NickCheck(String nick);

    int EmailCheck(String email);

    int PhoneCheck(String phone);

    String FindId(@Param("name") String name, @Param("phone") String phone);

    boolean checkUserNameAndEmail(@Param("userName") String userName, @Param("userEmail") String userEmail);

    void updatePasswordByEmail(@Param("email") String email, @Param("password") String password);

    int register(UserDTO dto);

    List<UserDTO> AdmingetAllUsers();

    // 소셜 로그인 사용자 등록 메서드 추가
    void registerSocialUser(UserDTO user);
    
    public void increaseFailedAttempts(UserDTO user);
    
    public void resetFailedAttempts(String userId);
    
    public void lockAccount(String userId);
    
    public void unlockAccount(String userId);
    
    String getUserAuthority(@Param("userId") String userId);
    
}
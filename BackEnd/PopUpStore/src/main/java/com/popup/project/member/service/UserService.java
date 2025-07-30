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
    
    // 소셜 로그인 사용자 조회 메서드 추가
    UserDTO findBySocialIdAndProvider(@Param("socialId") String socialId, @Param("provider") String provider);
    
    // 소셜 로그인 사용자 정보 업데이트 메서드 추가
    int updateUserBySocialIdAndProvider(UserDTO user);
    
    // 일반 사용자 정보 업데이트 메서드 추가
    int updateUserInfo(UserDTO user);
    
    // 사용자 삭제 메서드 추가
    int deleteUserById(String userId);
    
    // 사용자 검색 메서드 추가 (관리자용)
    List<UserDTO> searchUsersByIdOrNickname(@Param("query") String query);
}
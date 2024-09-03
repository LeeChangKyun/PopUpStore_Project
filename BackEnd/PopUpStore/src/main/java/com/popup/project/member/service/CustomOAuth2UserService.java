package com.popup.project.member.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.popup.project.member.auth.CustomUserDetails;
import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.dto.UserMapper;

import jakarta.servlet.http.HttpSession;

@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private HttpSession session;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {
        OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
        OAuth2User oAuth2User = delegate.loadUser(userRequest);

        if (oAuth2User == null) {
            throw new IllegalStateException("OAuth2User is null after loading user details from provider.");
        }

        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        String providerId = getProviderId(registrationId, oAuth2User.getAttributes());

        UserDTO user = findOrCreateUser(registrationId, providerId, oAuth2User.getAttributes());

        // 여기서 setEnabled와 setSocialEmail을 설정
        if (user != null) {
            user.setEnabled(true);
            user.setSocialEmail(getEmailFromAttributes(registrationId, oAuth2User.getAttributes()));
            userMapper.updateUserBySocialIdAndProvider(user);
            session.setAttribute("socialUser", user);
            return new CustomUserDetails(user);  // CustomUserDetails로 반환
        } else {
            throw new IllegalStateException("UserDTO is null after processing OAuth2 login.");
        }
    }

    private String getProviderId(String registrationId, Map<String, Object> attributes) {
        if ("google".equals(registrationId)) {
            return (String) attributes.get("sub");
        } else if ("naver".equals(registrationId)) {
            Map<String, Object> response = (Map<String, Object>) attributes.get("response");
            return (String) response.get("id");
        } else if ("kakao".equals(registrationId)) {
            return String.valueOf(attributes.get("id")); // 카카오의 고유 ID는 숫자로 반환될 수 있습니다.
        } else {
            return (String) attributes.get("id");
        }
    }

    private UserDTO findOrCreateUser(String registrationId, String providerId, Map<String, Object> attributes) {
        UserDTO user = userMapper.findBySocialIdAndProvider(providerId, registrationId);

        if (user == null) {
            user = new UserDTO();
            user.setSocialId(providerId);
            user.setSocialProvider(registrationId);
            user.setUserAuthority("ROLE_USER");
            user.setUserEmail(getEmailFromAttributes(registrationId, attributes));
            user.setUserId(UUID.randomUUID().toString());
            user.setUserNick(registrationId + "_" + providerId);
            user.setUserPwd("SOCIAL_LOGIN");
            user.setUserName("Social User");
            user.setUserPhone("000-0000-0000");
            user.setUserZipcode("00000");
            user.setUserAddress("Social Address");
            user.setEnabled(true);  // 새로운 사용자 생성 시 enabled 설정
            user.setSocialEmail(getEmailFromAttributes(registrationId, attributes)); // 소셜 이메일 설정

            userMapper.saveSocialUser(user);
        }

        return user;
    }

    private String getEmailFromAttributes(String registrationId, Map<String, Object> attributes) {
        if ("naver".equals(registrationId)) {
            Map<String, Object> response = (Map<String, Object>) attributes.get("response");
            return (String) response.get("email");
        } else if ("kakao".equals(registrationId)) {
            Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
            return (String) kakaoAccount.get("email"); // 카카오의 이메일 주소
        } else {
            return (String) attributes.get("email");
        }
    }
}
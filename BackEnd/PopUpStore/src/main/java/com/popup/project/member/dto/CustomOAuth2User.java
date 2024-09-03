package com.popup.project.member.dto;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

public class CustomOAuth2User implements OAuth2User {

    private OAuth2User oAuth2User;
    private String provider;
    private String userAuthority;
    
    public CustomOAuth2User(OAuth2User oAuth2User, String provider, String userAuthority) {
        this.oAuth2User = oAuth2User;
        this.provider = provider;
        this.userAuthority = userAuthority;
    }

    @Override
    public Map<String, Object> getAttributes() {
        return oAuth2User.getAttributes();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singleton(new SimpleGrantedAuthority(this.userAuthority));
    }

    @Override
    public String getName() {
        // 프로바이더에 따라 적절한 필드 사용
        if ("kakao".equals(provider)) {
            return String.valueOf(oAuth2User.getAttribute("id"));
        } else if ("google".equals(provider)) {
            return oAuth2User.getAttribute("sub");
        } else if ("naver".equals(provider)) {
            return ((Map<String, Object>) oAuth2User.getAttribute("response")).get("id").toString();
        }
        return "unknown"; // 기본 값 설정
    }

    public String getProvider() {
        return provider;
    }

    public OAuth2User getOAuth2User() {
        return oAuth2User;
    }
}
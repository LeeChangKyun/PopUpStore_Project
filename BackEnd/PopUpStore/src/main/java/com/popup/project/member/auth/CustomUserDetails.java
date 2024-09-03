package com.popup.project.member.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.popup.project.member.dto.CustomOAuth2User;
import com.popup.project.member.dto.UserDTO;

public class CustomUserDetails implements UserDetails, OAuth2User {

    private final UserDTO user;
    private final CustomOAuth2User oauth2User;

    public CustomUserDetails(UserDTO user, CustomOAuth2User oauth2User) {
        this.user = user;
        this.oauth2User = oauth2User;
    }

    public CustomUserDetails(UserDTO user) {
        this.user = user;
        this.oauth2User = null;
    }

    public CustomUserDetails(CustomOAuth2User oauth2User) {
        this.user = null;
        this.oauth2User = oauth2User;
    }

    @Override
    public String getPassword() {
        return user != null ? user.getUserPwd() : null;
    }

    @Override
    public String getUsername() {
        // userId가 null일 경우 기본값 반환
        return (user != null && user.getUserId() != null) ? user.getUserId() : (oauth2User != null ? oauth2User.getName() : "defaultUsername");
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if (oauth2User != null) {
            return oauth2User.getAuthorities();
        } else if (user != null) {
            List<GrantedAuthority> authorities = new ArrayList<>();
            String authority = user.getUserAuthority();
            if (authority != null) {
                authorities.add(new SimpleGrantedAuthority(authority));
            }
            return authorities;
        }
        return Collections.emptyList();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return user != null ? user.isEnabled() : true;
    }

    @Override
    public Map<String, Object> getAttributes() {
        return oauth2User != null ? oauth2User.getAttributes() : null;
    }

    @Override
    public String getName() {
        if (oauth2User != null) {
            return oauth2User.getName();
        } else if (user != null) {
            return user.getUserId();
        }
        return "unknown"; // null이 반환되지 않도록 기본 값을 설정
    }

    public UserDTO getUser() {
        return user;
    }
    
    public CustomOAuth2User getOAuth2User() {
        return oauth2User;
    }
}
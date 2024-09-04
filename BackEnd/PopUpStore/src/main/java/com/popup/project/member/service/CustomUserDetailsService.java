package com.popup.project.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.popup.project.member.auth.CustomUserDetails;
import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.mapper.UserMapper;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
    private UserMapper userMapper;

	@Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("Attempting to load user by username: " + username); // 로그 추가
        UserDTO user = userMapper.getUserByUsername(username);
        if (user == null) {	
            System.out.println("User not found: " + username); // 로그 추가
            throw new UsernameNotFoundException("User not found");
        }

        System.out.println("User found: " + user.getUserId()); // 로그 추가
        return new CustomUserDetails(user);
    }
	
}

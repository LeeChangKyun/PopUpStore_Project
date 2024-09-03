package com.popup.project.member.dto;

import java.sql.Date;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UserDTO {
	
	@NotBlank(message = "아이디는 필수 입력사항입니다.")
	@Size(min = 4, max = 12, message = "아이디는 4~12자 이내로 입력해주세요.")
	private String userId;
	
	@NotBlank(message = "닉네임은 필수 입력사항입니다.")
	@Size(min = 3, max = 10, message = "닉네임은 4~10자 이내로 입력해주세요.")
	private String userNick;
	
	@NotBlank(message = "비밀번호는 필수 입력사항입니다.")
	@Size(min = 8, max = 20, message = "비밀번호는 8~20자 이내로 입력해주세요.")
	private String userPwd; 
	
	@NotBlank(message = "비밀번호 확인은 필수 입력사항입니다.")
	private String userPwdConfirm;
	
	@NotBlank(message = "이름은 필수 입력사항입니다.")
	private String userName;
	
	@NotBlank(message = "전화번호는 필수 입력사항입니다.")
	private String userPhone;
	
	@NotBlank(message = "이메일은 필수 입력사항입니다.")
	@Email(message = "이메일 형식이 올바르지 않습니다.")
	private String userEmail;
	
	@NotBlank(message = "우편번호는 필수 입력사항입니다.")
	private String userZipcode;
	
	@NotBlank(message = "주소는 필수 입력사항입니다.")
	private String userAddress;
	
	private Date userCreatedate;
	
	private String userAuthority;
	
	private boolean enabled;
	
	private String socialId;        // 추가
	
    private String socialProvider;  // 추가
    
    private String socialEmail;     // 추가
	
    private int failedAttempts;      // 로그인 실패 시도 횟수
    
    private boolean accountLocked;   // 계정 잠김 여부
    
}

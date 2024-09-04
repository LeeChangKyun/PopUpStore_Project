package com.popup.project.board.review.model;

import java.util.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("ReviewUser")  // MyBatis에서 사용할 별칭을 정의
public class ReviewUser {

	public ReviewUser() {}
	
    private String userNick;		// 닉네임
    
//    // 현재 리뷰 게시판은 userNick만 사용중...
//    // 나중에 기능 추가시 사용할 수 있으니 작성은 해뒀음
//    private String userId;			// ID
//    private String userPwd;			// 비밀번호
//    private String userName;		// 이름
//    private String userPhone;		// 전화번호
//    private String userEmail;		// 이메일
//    private String userZipcode;		// 우편번호
//    private String userAddress;		// 주소
//    private Date userCreateDate;	// 계정 생성일
//    private int enabled;            // 계정 활성화 상태 (기본값: 1)
//    private String socialId;        // 소셜 로그인 ID (예: Google, Kakao, Naver ID 등)
//    private String socialProvider;  // 소셜 로그인 제공자 (예: Google, Kakao, Naver 등)
//    private String socialEmail;     // 소셜 로그인 이메일 (사용자 이메일과 다를 수 있음) 
}
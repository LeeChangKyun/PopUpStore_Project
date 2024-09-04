package com.popup.project.board.review.model;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.repository.query.Param;

@Mapper
public interface ReviewUserMapper {

	// 사용자 닉네임으로 사용자 조회
	ReviewUser findByUserNick(@Param("userNick") String userNick);
    
//	  // 나중에 기능 추가시 필요하면 사용할지도?
//    // 사용자 이름을 기반으로 사용자의 역할(role) 조회
//    @Select("SELECT authority FROM USERS WHERE user_name = #{userName}")
//    String findRoleByUserName(@Param("userName") String userName);
//    
//    // 사용자 닉네임을 기반으로 사용자의 역할(role) 조회
//    @Select("SELECT authority FROM USERS WHERE user_nick = #{userNick}")
//    String findRoleByUserNick(@Param("userNick") String userNick);
}

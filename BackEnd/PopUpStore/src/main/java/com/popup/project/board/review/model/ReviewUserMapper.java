package com.popup.project.board.review.model;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.repository.query.Param;

@Mapper
public interface ReviewUserMapper {

    // 사용자 닉네임으로 사용자 찾기
	ReviewUser findByUserNick(@Param("userNick") String userNick);

    // 사용자 등록 (필요에 따라 추가)
    int insertUser(ReviewUser user);

    // 사용자 정보 수정 (필요에 따라 추가)
    int updateUser(ReviewUser user);

    // 사용자 삭제 (필요에 따라 추가)
    int deleteUser(String userNick);
    
    int deleteName(String userName);
    
    @Select("SELECT role FROM USERS WHERE user_name = #{userName}")
    String findRoleByUserName(@Param("userName") String userName);
    
    @Select("SELECT role FROM USERS WHERE user_nick = #{userNick}")
    String findRoleByUserNick(@Param("userNick") String userNick);
}

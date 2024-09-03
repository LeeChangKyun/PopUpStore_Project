package com.popup.project.board.inquiry.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface InquiryLikeMapper {

    void insertLike(@Param("inquiryNum") Long inquiryNum, @Param("userNick") String userNick);

    void deleteLike(@Param("inquiryNum") Long inquiryNum, @Param("userNick") String userNick);

    int checkLike(@Param("inquiryNum") Long inquiryNum, @Param("userNick") String userNick);

    int getLikeCount(@Param("inquiryNum") Long inquiryNum);
    
    List<String> getLikeUsers(@Param("inquiryNum") Long inquiryNum);
}
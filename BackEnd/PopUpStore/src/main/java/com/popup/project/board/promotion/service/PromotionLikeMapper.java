package com.popup.project.board.promotion.service;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PromotionLikeMapper {

    void insertLike(@Param("promotionNum") Long promotionNum, @Param("userNick") String userNick);

    void deleteLike(@Param("promotionNum") Long promotionNum, @Param("userNick") String userNick);

    int checkLike(@Param("promotionNum") Long promotionNum, @Param("userNick") String userNick);

    int getLikeCount(@Param("promotionNum") Long promotionNum);
}
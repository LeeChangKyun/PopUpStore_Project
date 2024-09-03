package com.popup.project.board.review.model;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReviewLikesMapper {

    boolean existsByReviewAndUser(@Param("reviewNum") int reviewNum, @Param("userNick") String userNick);

    int countByReviewNum(@Param("reviewNum") int reviewNum);

    void deleteByReviewAndUser(@Param("reviewNum") int reviewNum, @Param("userNick") String userNick);

    void insertLike(@Param("reviewNum") int reviewNum, @Param("userNick") String userNick);
}

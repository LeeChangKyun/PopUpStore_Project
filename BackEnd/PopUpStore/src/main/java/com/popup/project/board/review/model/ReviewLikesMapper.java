package com.popup.project.board.review.model;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReviewLikesMapper {

	// 특정 게시글에 대해 사용자가 이미 좋아요를 눌렀는지 확인
    boolean existsByReviewAndUser(@Param("reviewNum") int reviewNum, @Param("userNick") String userNick);

    // 특정 게시글에 대한 좋아요 개수를 가져옴
    int countByReviewNum(@Param("reviewNum") int reviewNum);

    // 특정 게시글에 대해 사용자가 누른 좋아요를 취소
    void deleteByReviewAndUser(@Param("reviewNum") int reviewNum, @Param("userNick") String userNick);

    // 특정 게시글에 대해 사용자가 좋아요를 추가
    void insertLike(@Param("reviewNum") int reviewNum, @Param("userNick") String userNick);
}

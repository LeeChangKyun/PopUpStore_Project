package com.popup.project.board.review.model;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReviewLikesMapper {

    // 특정 리뷰와 특정 사용자가 좋아요를 눌렀는지 확인
    boolean existsByReviewAndUser(@Param("reviewNum") int reviewNum, @Param("userNick") String userNick);

    // 특정 리뷰의 전체 좋아요 수를 반환
    int countByReview(@Param("reviewNum") int reviewNum);

    // 특정 리뷰와 특정 사용자에 해당하는 좋아요 삭제
    int deleteByReviewAndUser(@Param("reviewNum") int reviewNum, @Param("userNick") String userNick);

    // 좋아요 추가
    int insertLike(ReviewLikes like);
}

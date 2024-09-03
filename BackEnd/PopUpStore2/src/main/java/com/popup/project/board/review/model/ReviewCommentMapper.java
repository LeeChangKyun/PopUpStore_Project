package com.popup.project.board.review.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.repository.query.Param;

@Mapper
public interface ReviewCommentMapper {
    
    // 댓글 추가
    int insertComment(ReviewComment comment);

    // 리뷰 번호로 댓글 조회
    List<ReviewComment> selectCommentsByReviewNum(int reviewNum);

    // 댓글 삭제
    int deleteComment(int commentId);

    // 댓글 ID로 리뷰 번호 조회
    Integer findReviewNumByCommentId(int commentId);

    // 댓글 ID로 댓글 조회
    @Select("SELECT * FROM REVIEWS_COMMENTS WHERE comment_id = #{commentId}")
    ReviewComment findCommentById(@Param("commentId") int commentId);
    
    // 리뷰 번호로 댓글 수 조회
    @Select("SELECT COUNT(*) FROM REVIEWS_COMMENTS WHERE review_num = #{reviewNum}")
    int countByReviewNum(@Param("reviewNum") int reviewNum);
}

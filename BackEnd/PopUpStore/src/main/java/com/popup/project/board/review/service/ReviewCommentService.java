package com.popup.project.board.review.service;

import com.popup.project.board.review.model.ReviewComment;
import com.popup.project.board.review.model.ReviewCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReviewCommentService {

    private final ReviewCommentMapper reviewCommentMapper;

    @Autowired
    public ReviewCommentService(ReviewCommentMapper reviewCommentMapper) {
        this.reviewCommentMapper = reviewCommentMapper;
    }

    // 댓글 추가
    @Transactional
    public void reviewCommentAdd(ReviewComment comment) {
        reviewCommentMapper.insertComment(comment);
    }

    // 댓글 삭제
    public int reviewCommentDelete(Integer commentId) {
        return reviewCommentMapper.deleteComment(commentId);
    }

    // 댓글 ID로 게시글 ID를 조회
    public Integer getReviewNumByCommentId(int commentId) {
        return reviewCommentMapper.findReviewNumByCommentId(commentId);
    }

    // 특정 게시글에 속한 모든 댓글을 조회
    public List<ReviewComment> getCommentsByReviewNum(int reviewNum) {
        return reviewCommentMapper.selectCommentsByReviewNum(reviewNum);
    }
    
    // 특정 게시글에 속한 댓글 수를 조회
    public int getCommentCountByReviewNum(int reviewNum) {
        return reviewCommentMapper.countByReviewNum(reviewNum);
    }

    // 댓글 ID로 댓글을 조회
    public ReviewComment getCommentById(int commentId) {
        return reviewCommentMapper.findCommentById(commentId);
    }
}

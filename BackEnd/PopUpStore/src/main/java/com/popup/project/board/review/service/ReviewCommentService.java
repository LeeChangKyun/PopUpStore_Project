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

    @Transactional
    public void reviewCommentAdd(ReviewComment comment) {
        reviewCommentMapper.insertComment(comment);
    }

    public int reviewCommentDelete(Integer commentId) {
        return reviewCommentMapper.deleteComment(commentId);
    }

    public Integer getReviewNumByCommentId(int commentId) {
        return reviewCommentMapper.findReviewNumByCommentId(commentId);
    }

    public List<ReviewComment> getCommentsByReviewNum(int reviewNum) {
        return reviewCommentMapper.selectCommentsByReviewNum(reviewNum);
    }
    
    public int getCommentCountByReviewNum(int reviewNum) {
        return reviewCommentMapper.countByReviewNum(reviewNum);
    }

    public ReviewComment getCommentById(int commentId) {
        return reviewCommentMapper.findCommentById(commentId);
    }

    
}

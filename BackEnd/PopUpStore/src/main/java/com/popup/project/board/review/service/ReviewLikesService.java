package com.popup.project.board.review.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popup.project.board.review.model.ReviewLikesMapper;

@Service
public class ReviewLikesService {

    private final ReviewLikesMapper reviewLikesMapper;

    @Autowired
    public ReviewLikesService(ReviewLikesMapper reviewLikesMapper) {
        this.reviewLikesMapper = reviewLikesMapper;
    }

    public void addLike(int reviewNum, String userNick) {
        if (!isLiked(reviewNum, userNick)) {
            reviewLikesMapper.insertLike(reviewNum, userNick);
        }
    }

    public void deleteLike(int reviewNum, String userNick) {
        if (isLiked(reviewNum, userNick)) {
            reviewLikesMapper.deleteByReviewAndUser(reviewNum, userNick);
            int likeCount = reviewLikesMapper.countByReviewNum(reviewNum);
            if (likeCount < 0) {
                likeCount = 0; // 좋아요 수가 음수로 내려가지 않도록 설정
            }
        }
    }

    public int getLikeCount(int reviewNum) {
        return reviewLikesMapper.countByReviewNum(reviewNum);
    }

    public boolean isLiked(int reviewNum, String userNick) {
        return reviewLikesMapper.existsByReviewAndUser(reviewNum, userNick);
    }
}

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

    // 좋아요 추가
    public void addLike(int reviewNum, String userNick) {
        if (!isLiked(reviewNum, userNick)) {
            reviewLikesMapper.insertLike(reviewNum, userNick);
        }
    }

    // 좋아요 삭제
    public void deleteLike(int reviewNum, String userNick) {
        if (isLiked(reviewNum, userNick)) {
            reviewLikesMapper.deleteByReviewAndUser(reviewNum, userNick);
            int likeCount = reviewLikesMapper.countByReviewNum(reviewNum);
            // 좋아요 수가 음수로 내려가지 않도록 설정
            if (likeCount < 0) {
                likeCount = 0;
            }
        }
    }

    // 게시글의 좋아요 개수를 조회
    public int getLikeCount(int reviewNum) {
        return reviewLikesMapper.countByReviewNum(reviewNum);
    }

    // 사용자가 특정 게시글에 좋아요를 눌렀는지 확인
    public boolean isLiked(int reviewNum, String userNick) {
        return reviewLikesMapper.existsByReviewAndUser(reviewNum, userNick);
    }
}

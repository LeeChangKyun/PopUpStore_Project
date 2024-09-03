package com.popup.project.board.review.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.popup.project.board.review.model.ReviewBoard;
import com.popup.project.board.review.model.ReviewBoardMapper;
import com.popup.project.board.review.model.ReviewLikes;
import com.popup.project.board.review.model.ReviewLikesMapper;
import com.popup.project.board.review.model.ReviewUser;
import com.popup.project.board.review.model.ReviewUserMapper;

@Service
public class ReviewLikesService {

    private final ReviewLikesMapper reviewLikesMapper;
    private final ReviewBoardMapper reviewBoardMapper;
    private final ReviewUserMapper reviewUserMapper;

    @Autowired
    public ReviewLikesService(ReviewLikesMapper reviewLikesMapper, ReviewBoardMapper reviewBoardMapper, ReviewUserMapper reviewUserMapper) {
        this.reviewLikesMapper = reviewLikesMapper;
        this.reviewBoardMapper = reviewBoardMapper;
        this.reviewUserMapper = reviewUserMapper;
    }

    @Transactional
    public boolean toggleLike(int reviewNum, String userNick) {
        ReviewBoard review = reviewBoardMapper.getPostById(reviewNum);
        if (review == null) {
            throw new IllegalArgumentException("Invalid review ID");
        }

        ReviewUser user = reviewUserMapper.findByUserNick(userNick);
        if (user == null) {
            throw new IllegalArgumentException("Invalid user nickname");
        }

        boolean exists = reviewLikesMapper.existsByReviewAndUser(reviewNum, userNick);

        if (exists) {
            reviewLikesMapper.deleteByReviewAndUser(reviewNum, userNick);
            review.decrementLikeCount();  
        } else {
            ReviewLikes like = new ReviewLikes();
            like.setReviewNum(reviewNum);
            like.setUserNick(userNick);
            reviewLikesMapper.insertLike(like);
            review.incrementLikeCount(); 
        }

        reviewBoardMapper.updatePost(review);

        return !exists; 
    }

}

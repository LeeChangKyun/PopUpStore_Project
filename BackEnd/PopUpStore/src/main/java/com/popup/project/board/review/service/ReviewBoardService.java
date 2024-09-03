package com.popup.project.board.review.service;

import com.popup.project.board.review.model.ReviewBoard;
import com.popup.project.board.review.model.ReviewBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReviewBoardService {

    private final ReviewBoardMapper reviewBoardMapper;
    private final ReviewLikesService reviewLikesService; 

    @Autowired
    public ReviewBoardService(ReviewBoardMapper reviewBoardMapper, ReviewLikesService reviewLikesService) {
        this.reviewBoardMapper = reviewBoardMapper;
        this.reviewLikesService = reviewLikesService; 
    }

    @Transactional
    public ReviewBoard getPostById(int reviewNum) {
        ReviewBoard post = reviewBoardMapper.getPostById(reviewNum);
        int likeCount = reviewLikesService.getLikeCount(reviewNum); // 좋아요 개수 가져오기
        post.setReviewLikecount(likeCount); // ReviewBoard 객체에 설정
        reviewBoardMapper.incrementVisitCount(reviewNum); // 조회수 증가
        return post;
    }

    @Transactional
    public int writePost(ReviewBoard review) {
        return reviewBoardMapper.insertWrite(review);
    }

    @Transactional
    public int editPost(ReviewBoard review) {
        return reviewBoardMapper.updatePost(review);
    }

    @Transactional
    public void deletePost(int reviewNum) {
        reviewBoardMapper.deletePost(reviewNum);
    }

    public List<ReviewBoard> getPostsByPage(int start, int end) {
        List<ReviewBoard> posts = reviewBoardMapper.selectListPage(start, end);
        
        // 각 게시물에 대한 좋아요 개수를 설정
        for (ReviewBoard post : posts) {
            int likeCount = reviewLikesService.getLikeCount(post.getReviewNum());
            post.setReviewLikecount(likeCount);
        }

        return posts;
    }

    public int getPostCount() {
        return reviewBoardMapper.selectCount();
    }

    @Transactional
    public void incrementLikeCount(int reviewNum) {
        reviewBoardMapper.incrementLikeCount(reviewNum);
    }

    public List<ReviewBoard> searchPostsByPage(String searchField, String searchWord, int start, int end) {
        List<ReviewBoard> posts = reviewBoardMapper.searchPostsByPage(searchField, searchWord, start, end);

        // 각 게시물에 대한 좋아요 개수를 설정
        for (ReviewBoard post : posts) {
            int likeCount = reviewLikesService.getLikeCount(post.getReviewNum());
            post.setReviewLikecount(likeCount);
        }

        return posts;
    }

    public int getSearchPostCount(String searchField, String searchWord) {
        return reviewBoardMapper.searchPostCount(searchField, searchWord);
    }

    public List<ReviewBoard> searchPostsByPageExample() {
        String searchField = "review_title";
        String searchWord = "example";
        int start = 1;
        int end = 10;

        List<ReviewBoard> posts = this.searchPostsByPage(searchField, searchWord, start, end);

        // 각 게시물에 대한 좋아요 개수를 설정
        for (ReviewBoard post : posts) {
            int likeCount = reviewLikesService.getLikeCount(post.getReviewNum());
            post.setReviewLikecount(likeCount);
        }

        return posts;
    }

    // 사용자가 게시물에 좋아요를 눌렀는지 확인하는 메서드 추가
    public boolean isUserLikedPost(int reviewNum, String userNick) {
        return reviewLikesService.isLiked(reviewNum, userNick);
    }
}


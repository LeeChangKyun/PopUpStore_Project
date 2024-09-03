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

    @Autowired
    public ReviewBoardService(ReviewBoardMapper reviewBoardMapper) {
        this.reviewBoardMapper = reviewBoardMapper;
    }

    @Transactional
    public ReviewBoard getPostById(int reviewNum) {
        reviewBoardMapper.incrementVisitCount(reviewNum);
        return reviewBoardMapper.getPostById(reviewNum);
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
        return reviewBoardMapper.selectListPage(start, end);
    }

    public int getPostCount() {
        return reviewBoardMapper.selectCount();
    }

    @Transactional
    public void incrementLikeCount(int reviewNum) {
        reviewBoardMapper.incrementLikeCount(reviewNum);
    }

    public List<ReviewBoard> searchPostsByPage(String searchField, String searchWord, int start, int end) {
        return reviewBoardMapper.searchPostsByPage(searchField, searchWord, start, end);
    }

    public int getSearchPostCount(String searchField, String searchWord) {
        return reviewBoardMapper.searchPostCount(searchField, searchWord);
    }
    
    public List<ReviewBoard> searchPostsByPageExample() {
        String searchField = "review_title";
        String searchWord = "example";
        int start = 1;
        int end = 10;

        return this.searchPostsByPage(searchField, searchWord, start, end);
    }

}

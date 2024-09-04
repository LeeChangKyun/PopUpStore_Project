package com.popup.project.board.review.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.popup.project.board.review.model.ReviewBoard;
import com.popup.project.board.review.model.ReviewBoardMapper;

@Service
public class ReviewBoardService {

    private final ReviewBoardMapper reviewBoardMapper;
    private final ReviewLikesService reviewLikesService; 
    private final ReviewUploadService reviewUploadService; 

    @Autowired
    public ReviewBoardService(ReviewBoardMapper reviewBoardMapper, 
    		ReviewLikesService reviewLikesService, ReviewUploadService reviewUploadService) {
        this.reviewBoardMapper = reviewBoardMapper;
        this.reviewLikesService = reviewLikesService; 
        this.reviewUploadService = reviewUploadService; 
    }

    // 게시글 ID로 게시글 조회
    @Transactional
    public ReviewBoard getPostById(int reviewNum) {
        ReviewBoard post = reviewBoardMapper.getPostById(reviewNum);
        // 좋아요 개수 가져옴
        int likeCount = reviewLikesService.getLikeCount(reviewNum);
        // 좋아요 개수를 게시글 객체에 설정
        post.setReviewLikecount(likeCount); 
        // 조회수 증가
        reviewBoardMapper.incrementVisitCount(reviewNum); 
        return post;
    }

    // 새 게시글 작성
    @Transactional
    public int writePost(ReviewBoard review) {
        return reviewBoardMapper.insertWrite(review);
    }

    // 게시글 수정 (파일 수정, 삭제, 업로드 함께 처리)
    @Transactional
    public void editPost(ReviewBoard review, boolean deleteFile, List<MultipartFile> reviewOfile) {
        if (deleteFile) {
        	// 실제 파일 삭제
            reviewUploadService.deleteFile(review.getExistingFile());
            // DB에서 파일 정보 삭제
            reviewBoardMapper.deleteFileInfo(review.getReviewNum()); 
            // 리뷰 객체에서 파일 정보 삭제
            review.setReviewOfile(null); 
        } else if (reviewOfile != null && !reviewOfile.isEmpty()) { 
            try {
                List<String> savedFileNames = reviewUploadService.saveFiles(reviewOfile); 
                // 저장된 파일명을 저장
                review.setReviewOfile(String.join(",", savedFileNames));
            } catch (IOException e) {
                e.printStackTrace();
                throw new RuntimeException("파일 저장 중 오류 발생");
            }
        }
        reviewBoardMapper.updatePost(review); 
    }

    // 게시글 삭제
    @Transactional
    public void deletePost(int reviewNum) {
        reviewBoardMapper.deletePost(reviewNum);
    }

    // 페이지 번호에 따라 게시글 리스트를 가져옴
    public List<ReviewBoard> getPostsByPage(int start, int end) {
        List<ReviewBoard> posts = reviewBoardMapper.selectListPage(start, end);
        
        // 각 게시물에 대한 좋아요 개수를 설정
        for (ReviewBoard post : posts) {
            int likeCount = reviewLikesService.getLikeCount(post.getReviewNum());
            post.setReviewLikecount(likeCount);
        }

        return posts;
    }

    // 전체 게시글 수를 가져옴
    public int getPostCount() {
        return reviewBoardMapper.selectCount();
    }

    // 게시글의 좋아요 개수를 증가시킴
    @Transactional
    public void incrementLikeCount(int reviewNum) {
        reviewBoardMapper.incrementLikeCount(reviewNum);
    }

    // 검색 필드와 검색어를 기반으로 게시글 리스트를 가져옴
    public List<ReviewBoard> searchPostsByPage(String searchField, String searchWord, int start, int end) {
        List<ReviewBoard> posts = reviewBoardMapper.searchPostsByPage(searchField, searchWord, start, end);

        // 각 게시물에 대한 좋아요 개수를 설정
        for (ReviewBoard post : posts) {
            int likeCount = reviewLikesService.getLikeCount(post.getReviewNum());
            post.setReviewLikecount(likeCount);
        }

        return posts;
    }

    // 검색 필드와 검색어를 기반으로 검색된 게시글 수를 가져옴
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

    // 사용자가 게시글에 좋아요를 눌렀는지 확인
    public boolean isUserLikedPost(int reviewNum, String userNick) {
        return reviewLikesService.isLiked(reviewNum, userNick);
    }
    
    // 게시글의 파일 정보를 삭제
    @Transactional
    public void deleteFileInfo(int reviewNum) {
        reviewBoardMapper.deleteFileInfo(reviewNum);
    }
}


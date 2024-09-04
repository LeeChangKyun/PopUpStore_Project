package com.popup.project.board.review.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.popup.project.board.review.model.ReviewBoard;
import com.popup.project.board.review.model.ReviewBoardMapper;
import com.popup.project.board.review.model.ReviewComment;
import com.popup.project.board.review.model.ReviewUserMapper;
import com.popup.project.board.review.service.ReviewBoardService;
import com.popup.project.board.review.service.ReviewCommentService;
import com.popup.project.board.review.service.ReviewLikesService;
import com.popup.project.board.review.service.ReviewUploadService;
import com.popup.project.board.review.utils.ReviewBoardPage;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewController {

    private final ReviewBoardService reviewBoardService;
    private final ReviewCommentService reviewCommentService;
    private final ReviewLikesService reviewLikesService;
    private final ReviewUploadService reviewUploadService;

    @Autowired
    public ReviewController(
            ReviewBoardService reviewBoardService, 
            ReviewCommentService reviewCommentService, 
            ReviewLikesService reviewLikesService,
            ReviewUploadService reviewUploadService,
            ReviewUserMapper reviewUserMapper,
            ReviewBoardMapper reviewBoardMapper) {
        this.reviewBoardService = reviewBoardService;
        this.reviewCommentService = reviewCommentService;
        this.reviewLikesService = reviewLikesService;
        this.reviewUploadService = reviewUploadService;
    }

    // 리스트 페이지
    @GetMapping("/{role}/review/reviewList")
    public String reviewList(
    		// @PathVariable("role") : 역할(role)에 따라 경로 설정
            @PathVariable("role") String role,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "searchField", required = false) String searchField,
            @RequestParam(value = "searchWord", required = false) String searchWord,
            Model model) {
        
    	// 페이지 당 게시글 수
        int pageSize = 10;
        int start = (page - 1) * pageSize + 1;
        int end = page * pageSize;

        List<ReviewBoard> boardList;
        int totalCount;
        
        // 검색 여부에 따라 리스트 조회
        if (searchField != null && !searchField.trim().isEmpty() && searchWord != null && !searchWord.trim().isEmpty()) {
            boardList = reviewBoardService.searchPostsByPage(searchField, searchWord, start, end);
            totalCount = reviewBoardService.getSearchPostCount(searchField, searchWord);
        } else {
            boardList = reviewBoardService.getPostsByPage(start, end);
            totalCount = reviewBoardService.getPostCount();
        }
        
        // 각 게시글에 댓글 수 추가(제목 옆에)
        boardList.forEach(post -> {
            int commentCount = reviewCommentService.getCommentCountByReviewNum(post.getReviewNum());
            // 댓글 수 설정
            post.setCommentCount(commentCount);
        });

        // 페이지네이션을 위한 HTML 코드 생성
        String pagingImg = ReviewBoardPage.pagingStr(totalCount, pageSize, 10, page, "/" + role + "/review/reviewList");

        // 모델에 데이터 추가
        model.addAttribute("boardList", boardList);
        model.addAttribute("page", page);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("pagingImg", pagingImg);
        model.addAttribute("searchField", searchField);
        model.addAttribute("searchWord", searchWord);
        
        // 역할(role)에 맞는 리스트 페이지로 이동
        return role + "/review/reviewList";
    }

    // 상세 페이지
    @GetMapping("/{role}/review/reviewView")
    public String reviewViewPost(
            @PathVariable("role") String role, 
            @RequestParam("reviewNum") int reviewNum, 
            Model model,
            HttpSession session) {

    	// 게시글 가져옴
        ReviewBoard post = reviewBoardService.getPostById(reviewNum);
        // 댓글 목록 가져옴
        List<ReviewComment> comments = reviewCommentService.getCommentsByReviewNum(reviewNum);
        
        // 세션에서 사용자 정보 가져옴
        String userNick = (String) session.getAttribute("userNick");

        // 사용자가 좋아요를 눌렀는지 확인
        boolean isLiked = false;
        if (userNick != null) {
            isLiked = reviewBoardService.isUserLikedPost(reviewNum, userNick);
        }

        // 댓글의 날짜 형식화
        comments.forEach(comment -> {
            String formattedDate = comment.getFormattedCommentDate();
            comment.setFormattedCommentDate(formattedDate);
        });

        // 모델에 데이터 추가
        model.addAttribute("dto", post);
        model.addAttribute("comments", comments);
        model.addAttribute("isLiked", isLiked);

        // 역할(role)에 맞는 상세 페이지로 이동
        return role + "/review/reviewView";
    }
    
    // 작성 페이지
    @GetMapping("/{role}/review/reviewWrite")
    public String reviewWriteGet(@PathVariable("role") String role) {
        return role + "/review/reviewWrite";
    }

    // 작성 처리
    @PostMapping("/{role}/review/reviewWrite")
    public String reviewWritePost(
        @PathVariable("role") String role,
        @RequestParam("reviewTitle") String reviewTitle,
        @RequestParam("reviewContent") String reviewContent,
        @RequestParam(value = "reviewOfile", required = false) List<MultipartFile> reviewOfile,
        HttpServletRequest request) {

        String userNick = (String) request.getSession().getAttribute("userNick");

        // 리뷰 객체 생성
        ReviewBoard review = new ReviewBoard();
        review.setReviewTitle(reviewTitle);
        review.setReviewContent(reviewContent);
        review.setUserNick(userNick);

        // 파일 업로드 처리
        if (reviewOfile != null && !reviewOfile.isEmpty()) {
            try {
                List<String> savedFileNames = reviewUploadService.saveFiles(reviewOfile);
                review.setReviewOfile(String.join(",", savedFileNames));
            } catch (IOException e) {
                e.printStackTrace();
                return "error";
            }
        } else {
        	// 업로드 파일이 없을 경우 null로 설정
        	review.setReviewOfile(null);
        }

        // 게시물 저장 처리
        try {
            reviewBoardService.writePost(review);
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }

        // 역할(role)에 맞는 리스트 페이지로 리다이렉트
        return "redirect:/" + role + "/review/reviewList";
    }

    // 수정 페이지
    @GetMapping("/{role}/review/reviewEdit")
    public String reviewEditGet(
        @PathVariable("role") String role,
        @RequestParam("reviewNum") int reviewNum, 
        Model model) {

        // 게시글 가져오기
        ReviewBoard review = reviewBoardService.getPostById(reviewNum);
        if (review == null) {
            // 역할(role)에 맞는 리스트 페이지로 리다이렉트
            return "redirect:/" + role + "/review/reviewList";
        }

        // 모델에 데이터 추가
        model.addAttribute("dto", review);
        
        // 역할(role)에 맞는 수정 페이지로 이동
        return role + "/review/reviewEdit";
    }

    // 수정 처리
    @PostMapping("/{role}/review/reviewEdit")
    public String reviewEditPost(
        @PathVariable("role") String role,
        @RequestParam("reviewNum") int reviewNum,
        @RequestParam("reviewTitle") String reviewTitle,
        @RequestParam("reviewContent") String reviewContent,
        @RequestParam(value = "reviewOfile", required = false) List<MultipartFile> reviewOfile,
        @RequestParam("existingFile") String existingFile,
        @RequestParam(value = "deleteFile", required = false, defaultValue = "false") boolean deleteFile,
        HttpServletRequest request,
        Model model) {

        String userNick = (String) request.getSession().getAttribute("userNick");

        // 작성자 검증
        ReviewBoard review = reviewBoardService.getPostById(reviewNum);
        if (review == null || (!review.getUserNick().equals(userNick) && !userNick.equals("관리자"))) {
            return "redirect:/" + role + "/review/reviewList";
        }

        // 리뷰 수정 내용 설정
        review.setReviewTitle(reviewTitle);
        review.setReviewContent(reviewContent);
        review.setExistingFile(existingFile);

        // reviewOfile을 전달하여 게시물 수정
        reviewBoardService.editPost(review, deleteFile, reviewOfile);

        // 역할(role)에 맞는 상세 페이지로 리다이렉트
        return "redirect:/" + role + "/review/reviewView?reviewNum=" + reviewNum;
    }

    // 삭제 처리
    @PostMapping("/reviewDelete")
    @ResponseBody
    public String reviewDeletePost(@RequestParam("reviewNum") int reviewNum, HttpSession session) {
        String userNick = (String) session.getAttribute("userNick");

        // 작성자 검증
        ReviewBoard review = reviewBoardService.getPostById(reviewNum);
        if (review == null || (!review.getUserNick().equals(userNick) && !userNick.equals("관리자"))) {
            return "fail";
        }

        reviewBoardService.deletePost(reviewNum);
        
        return "success";
    }
    
    // 댓글 목록 조회
    @GetMapping("/getReviewComments")
    @ResponseBody
    public List<ReviewComment> getReviewComments(@RequestParam("reviewNum") int reviewNum) {
    	return reviewCommentService.getCommentsByReviewNum(reviewNum);
    }

    // 댓글 추가
    @PostMapping("/{role}/reviewCommentAdd")
    public String reviewCommentAdd(
            @PathVariable("role") String role,
            @RequestParam("reviewNum") int reviewNum, 
            @RequestParam("commentContent") String commentContent, 
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession();
        String userNick = (String) session.getAttribute("userNick");

        ReviewComment comment = new ReviewComment();
        comment.setReviewNum(reviewNum);
        comment.setCommentContent(commentContent);
        comment.setUserNick(userNick);

        reviewCommentService.reviewCommentAdd(comment);

        redirectAttributes.addAttribute("reviewNum", reviewNum);
        
        return "redirect:/" + role + "/review/reviewView";
    }

    // 댓글 삭제
    @PostMapping("/{role}/reviewCommentDelete")
    @ResponseBody
    public String reviewCommentDelete(
        @PathVariable("role") String role, 
        @RequestParam("commentId") int commentId) {
        
        // 댓글 삭제 처리
        reviewCommentService.reviewCommentDelete(commentId);
        
        // 처리 완료 후 성공 메시지 반환
        return "success";
    }

    // 좋아요 추가
    @PostMapping("/review/addLike")
    public String addLike(@RequestParam("reviewNum") int reviewNum,
                          @SessionAttribute("userNick") String userNick) {
        reviewLikesService.addLike(reviewNum, userNick);
        return "redirect:/reviewView?reviewNum=" + reviewNum; 
    }

    // 좋아요 삭제
    @PostMapping("/review/deleteLike")
    public String deleteLike(@RequestParam("reviewNum") int reviewNum,
                             @SessionAttribute("userNick") String userNick) {
        reviewLikesService.deleteLike(reviewNum, userNick);
        return "redirect:/reviewView?reviewNum=" + reviewNum; 
    }
    
    // 좋아요 토글 (추가/삭제)
    @PostMapping("/review/toggleLike")
    @ResponseBody
    public Map<String, Object> toggleLike(@RequestParam("reviewNum") int reviewNum,
                                           @RequestParam("userNick") String userNick) {
        boolean userLiked = reviewLikesService.isLiked(reviewNum, userNick);

        if (userLiked) {
            reviewLikesService.deleteLike(reviewNum, userNick);
        } else {
            reviewLikesService.addLike(reviewNum, userNick);
        }

        int likeCount = reviewLikesService.getLikeCount(reviewNum);

        Map<String, Object> response = new HashMap<>();
        response.put("likeCount", likeCount);
        response.put("userLiked", !userLiked); // 응답에 토글된 상태 포함

        return response;
    }
}

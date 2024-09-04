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
    private final ReviewUserMapper reviewUserMapper;
    private final ReviewBoardMapper reviewBoardMapper;

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
        this.reviewUserMapper = reviewUserMapper;
        this.reviewBoardMapper = reviewBoardMapper;
    }

    @GetMapping("/{role}/review/reviewList")
    public String reviewList(
            @PathVariable("role") String role,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "searchField", required = false) String searchField,
            @RequestParam(value = "searchWord", required = false) String searchWord,
            Model model) {
        
        int pageSize = 10;
        int start = (page - 1) * pageSize + 1;
        int end = page * pageSize;

        List<ReviewBoard> boardList;
        int totalCount;
        if (searchField != null && !searchField.trim().isEmpty() && searchWord != null && !searchWord.trim().isEmpty()) {
            boardList = reviewBoardService.searchPostsByPage(searchField, searchWord, start, end);
            totalCount = reviewBoardService.getSearchPostCount(searchField, searchWord);
        } else {
            boardList = reviewBoardService.getPostsByPage(start, end);
            totalCount = reviewBoardService.getPostCount();
        }
        
        // 게시글 목록에서 제목 옆에 댓글 갯수를 표시하기 위해 추가함
        boardList.forEach(post -> {
            int commentCount = reviewCommentService.getCommentCountByReviewNum(post.getReviewNum());
            post.setCommentCount(commentCount); // ReviewBoard에 댓글 수 저장
        });


        String pagingImg = ReviewBoardPage.pagingStr(totalCount, pageSize, 10, page, "/" + role + "/review/reviewList");

        model.addAttribute("boardList", boardList);
        model.addAttribute("page", page);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("pagingImg", pagingImg);
        model.addAttribute("searchField", searchField);
        model.addAttribute("searchWord", searchWord);
        
        return role + "/review/reviewList";
    }
    
    @GetMapping("/{role}/review/reviewView")
    public String reviewViewPost(
            @PathVariable("role") String role, 
            @RequestParam("reviewNum") int reviewNum, 
            Model model,
            HttpSession session) {

        ReviewBoard post = reviewBoardService.getPostById(reviewNum);
        List<ReviewComment> comments = reviewCommentService.getCommentsByReviewNum(reviewNum);
        
        // 세션에서 사용자 정보를 가져옵니다.
        String userNick = (String) session.getAttribute("userNick");

        // 비회원 사용자 처리
        boolean isLiked = false;
        if (userNick != null) {
            // 해당 사용자가 이 게시물에 좋아요를 눌렀는지 확인
            isLiked = reviewBoardService.isUserLikedPost(reviewNum, userNick);
        }

        // 댓글의 날짜 형식을 설정합니다.
        comments.forEach(comment -> {
            String formattedDate = comment.getFormattedCommentDate();
            comment.setFormattedCommentDate(formattedDate);
        });

        // 모델에 데이터를 추가합니다.
        model.addAttribute("dto", post);
        model.addAttribute("comments", comments);
        model.addAttribute("isLiked", isLiked); // 사용자가 좋아요를 눌렀는지 여부를 추가

        return role + "/review/reviewView";
    }
    
    @GetMapping("/Member/review/reviewWrite")
    public String MemberReviewWriteGet() {
        return "Member/review/reviewWrite";
    }
    
    @GetMapping("/Admin/review/reviewWrite")
    public String AdminReviewWriteGet() {
        return "Admin/review/reviewWrite";
    }

    @PostMapping("/Member/review/reviewWrite")
    public String MemberReviewWritePost(
        @RequestParam("reviewTitle") String reviewTitle,
        @RequestParam("reviewContent") String reviewContent,
        @RequestParam(value = "reviewOfile", required = false) List<MultipartFile> reviewOfile,
        HttpServletRequest request) {

        String userNick = (String) request.getSession().getAttribute("userNick");
        
        ReviewBoard review = new ReviewBoard();
        review.setReviewTitle(reviewTitle);
        review.setReviewContent(reviewContent);
        review.setUserNick(userNick);

        if (reviewOfile != null && !reviewOfile.isEmpty()) {
            try {
                List<String> savedFileNames = reviewUploadService.saveFiles(reviewOfile);
                review.setReviewOfile(String.join(",", savedFileNames));
            } catch (IOException e) {
                e.printStackTrace();
                return "error";
            }
        } else {
            review.setReviewOfile(null); // 업로드 파일이 없을 경우 null로 설정
        }

        try {
            reviewBoardService.writePost(review);
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }

        return "redirect:/Member/review/reviewList";
    }
    
    @PostMapping("/Admin/review/reviewWrite")
    public String AdminReviewWritePost(
        @RequestParam("reviewTitle") String reviewTitle,
        @RequestParam("reviewContent") String reviewContent,
        @RequestParam(value = "reviewOfile", required = false) List<MultipartFile> reviewOfile,
        HttpServletRequest request) {

        String userNick = (String) request.getSession().getAttribute("userNick");

        ReviewBoard review = new ReviewBoard();
        review.setReviewTitle(reviewTitle);
        review.setReviewContent(reviewContent);
        review.setUserNick(userNick);

        if (reviewOfile != null && !reviewOfile.isEmpty()) {
            try {
                List<String> savedFileNames = reviewUploadService.saveFiles(reviewOfile);
                review.setReviewOfile(String.join(",", savedFileNames));
            } catch (IOException e) {
                e.printStackTrace();
                return "error";
            }
        } else {
            review.setReviewOfile(null); // 업로드 파일이 없을 경우 null로 설정
        }

        try {
            reviewBoardService.writePost(review);
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }

        return "redirect:/Admin/review/reviewList";
    }

    @GetMapping("/Member/review/reviewEdit")
    public String MemberReviewEditGet(@RequestParam("reviewNum") int reviewNum, Model model) {
        ReviewBoard review = reviewBoardService.getPostById(reviewNum);
        if (review == null) {
            return "redirect:/Member/review/reviewList";
        }
        model.addAttribute("dto", review);
        return "Member/review/reviewEdit";
    }
    
    @GetMapping("/Admin/review/reviewEdit")
    public String AdminReviewEditGet(@RequestParam("reviewNum") int reviewNum, Model model) {
        ReviewBoard review = reviewBoardService.getPostById(reviewNum);
        if (review == null) {
            return "redirect:/Admin/review/reviewList";
        }
        model.addAttribute("dto", review);
        return "Admin/review/reviewEdit";
    }

    @PostMapping("/Member/review/reviewEdit")
    public String MemberReviewEditPost(
        @RequestParam("reviewNum") int reviewNum,
        @RequestParam("reviewTitle") String reviewTitle,
        @RequestParam("reviewContent") String reviewContent,
        @RequestParam(value = "reviewOfile", required = false) List<MultipartFile> reviewOfile,
        @RequestParam("existingFile") String existingFile,
        @RequestParam(value = "deleteFile", required = false) boolean deleteFile,
        HttpServletRequest request,
        Model model) {

        String userNick = (String) request.getSession().getAttribute("userNick");

        // 작성자 검증
        ReviewBoard review = reviewBoardService.getPostById(reviewNum);
        if (review == null || (!review.getUserNick().equals(userNick) && !userNick.equals("관리자"))) {
            return "redirect:/Member/review/reviewList";
        }

        review.setReviewTitle(reviewTitle);
        review.setReviewContent(reviewContent);

        // 파일 삭제 처리
        if (deleteFile) {
            reviewUploadService.deleteFile(existingFile); // 실제 파일 삭제
            review.setReviewOfile(null); // DB에서도 파일 정보를 null로 업데이트
        } else if (reviewOfile != null && !reviewOfile.isEmpty()) {
            try {
                List<String> savedFileNames = reviewUploadService.saveFiles(reviewOfile);
                review.setReviewOfile(String.join(",", savedFileNames));
            } catch (IOException e) {
                e.printStackTrace();
                return "error";
            }
        } else {
            review.setReviewOfile(existingFile); // 기존 파일 유지
        }

        reviewBoardService.editPost(review);

        return "redirect:/Member/review/reviewView?reviewNum=" + reviewNum;
    }
    
    @PostMapping("/Admin/review/reviewEdit")
    public String AdminReviewEditPost(
        @RequestParam("reviewNum") int reviewNum,
        @RequestParam("reviewTitle") String reviewTitle,
        @RequestParam("reviewContent") String reviewContent,
        @RequestParam(value = "reviewOfile", required = false) List<MultipartFile> reviewOfile,
        @RequestParam("existingFile") String existingFile,
        @RequestParam(value = "deleteFile", required = false) boolean deleteFile,
        HttpServletRequest request,
        Model model) {

        String userNick = (String) request.getSession().getAttribute("userNick");

        // 작성자 검증
        ReviewBoard review = reviewBoardService.getPostById(reviewNum);
        if (review == null || (!review.getUserNick().equals(userNick) && !userNick.equals("관리자"))) {
            return "redirect:/Admin/review/reviewList";
        }

        review.setReviewTitle(reviewTitle);
        review.setReviewContent(reviewContent);

        // 파일 삭제 처리
        if (deleteFile) {
            reviewUploadService.deleteFile(existingFile); // 실제 파일 삭제
            review.setReviewOfile(null); // DB에서도 파일 정보를 null로 업데이트
        } else if (reviewOfile != null && !reviewOfile.isEmpty()) {
            try {
                List<String> savedFileNames = reviewUploadService.saveFiles(reviewOfile);
                review.setReviewOfile(String.join(",", savedFileNames));
            } catch (IOException e) {
                e.printStackTrace();
                return "error";
            }
        } else {
            review.setReviewOfile(existingFile); // 기존 파일 유지
        }

        reviewBoardService.editPost(review);  // 수정된 파일 정보로 DB 업데이트

        return "redirect:/Admin/review/reviewView?reviewNum=" + reviewNum;
    }

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
    
    @GetMapping("/getReviewComments")
    @ResponseBody
    public List<ReviewComment> getReviewComments(@RequestParam("reviewNum") int reviewNum) {
    	return reviewCommentService.getCommentsByReviewNum(reviewNum);
    }

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

    @PostMapping("/Member/reviewCommentDelete")
    @ResponseBody
    public String MemberReviewCommentDelete(@RequestParam("commentId") int commentId) {
        reviewCommentService.reviewCommentDelete(commentId);
        return "success";
    }
    
    @PostMapping("/Admin/reviewCommentDelete")
    @ResponseBody
    public String AdminReviewCommentDelete(@RequestParam("commentId") int commentId) {
        reviewCommentService.reviewCommentDelete(commentId);
        return "success";
    }

    @PostMapping("/review/addLike")
    public String addLike(@RequestParam("reviewNum") int reviewNum,
                          @SessionAttribute("userNick") String userNick) {
        reviewLikesService.addLike(reviewNum, userNick);
        return "redirect:/reviewView?reviewNum=" + reviewNum; 
    }

    @PostMapping("/review/deleteLike")
    public String deleteLike(@RequestParam("reviewNum") int reviewNum,
                             @SessionAttribute("userNick") String userNick) {
        reviewLikesService.deleteLike(reviewNum, userNick);
        return "redirect:/reviewView?reviewNum=" + reviewNum; 
    }
    
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

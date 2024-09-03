package com.popup.project.board.inquiry.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.popup.project.board.inquiry.dto.InquiryDTO;
import com.popup.project.board.inquiry.dto.InquirySimpleBbsDTO;
import com.popup.project.board.inquiry.dto.inquiryCommentDTO;
import com.popup.project.board.inquiry.service.InquiryFileDownService;
import com.popup.project.board.inquiry.service.InquiryLikeService;
import com.popup.project.board.inquiry.service.InquiryPagingService;
import com.popup.project.board.inquiry.service.InquirysBoardService;
import com.popup.project.board.inquiry.service.inquiryCommentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class InquiryController {

    @Autowired
    private InquirysBoardService boardService;
    
    
    @Autowired
    private InquiryFileDownService fileDownService;
    
    @Autowired
    private InquiryPagingService pagingService;
    
    @Autowired
    private inquiryCommentService commentService;
    
    @Autowired
    private InquiryLikeService inquiryLikeService;

    @RequestMapping("{role}/inquiry/inquiryList")
    public String boardList(Model model, HttpServletRequest req, InquiryDTO inquiryDTO, @PathVariable("role") String role)
    {
        int totalCount = boardService.getTotalCount(inquiryDTO);
        int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals("")) ? 1 : Integer.parseInt(req.getParameter("pageNum"));

        int start = (pageNum - 1) * InquiryPagingService.PAGE_SIZE + 1;
        int end = pageNum * InquiryPagingService.PAGE_SIZE;
        inquiryDTO.setStart(start);
        inquiryDTO.setEnd(end);

        Map<String, Object> maps = new HashMap<>();
        maps.put("totalCount", totalCount);
        maps.put("pageSize", InquiryPagingService.PAGE_SIZE);
        maps.put("pageNum", pageNum);
        model.addAttribute("maps", maps);

        model.addAttribute("lists", boardService.getBoardList(inquiryDTO));

        String searchField = req.getParameter("searchField");
        String searchKeyword = req.getParameter("searchKeyword");

        String pagingImg = pagingService.generatePaging(totalCount, pageNum, req.getContextPath() + "/" + role + "/inquiry/inquiryList?", searchField, searchKeyword);        model.addAttribute("pagingImg", pagingImg);

        model.addAttribute("searchField", searchField);
        model.addAttribute("searchKeyword", searchKeyword);

        return role + "/inquiry/inquiryList";
    }

    @GetMapping("/inquiryWrite")
    public String boardWriteGet(Model model) {
        return "Member/inquiry/inquiryWrite";
    }
    
    @GetMapping("/Admin/inquiryWrite")
    public String AdminboardWriteGet(Model model) {
        return "Admin/inquiry/inquiryWrite";
    }
    

    @PostMapping("/inquiryWrite")
    public String writePost(@RequestParam(name = "userNick") String userNick,
            @RequestParam("inquiry_title") String inquiryTitle,
            @RequestParam("inquiry_content") String inquiryContent,
            @RequestParam(value = "inquiry_ofile", required = false) MultipartFile inquiryOfile,
            @RequestParam(value = "inquiry_sfile", required = false) MultipartFile inquirySfile,
            RedirectAttributes redirectAttributes) {

        InquirySimpleBbsDTO dto = new InquirySimpleBbsDTO();
        dto.setInquiry_title(inquiryTitle);
        dto.setInquiry_content(inquiryContent);
        dto.setUser_nick(userNick);  // 닉네임 설정
        
        try {
            int result = boardService.writePost(dto, inquiryOfile, inquirySfile);
            if (result <= 0) {
                throw new RuntimeException("Post writing failed");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/error?message=fileUploadFailed";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/error?message=dataWriteFailed";
        }
        
        return "redirect:/Member/inquiry/inquiryList";
    }
    
    @PostMapping("/Admin/inquiryWrite")
    public String AdminwritePost(@RequestParam(name = "userNick") String userNick,
            @RequestParam("inquiry_title") String inquiryTitle,
            @RequestParam("inquiry_content") String inquiryContent,
            @RequestParam(value = "inquiry_ofile", required = false) MultipartFile inquiryOfile,
            @RequestParam(value = "inquiry_sfile", required = false) MultipartFile inquirySfile,
            RedirectAttributes redirectAttributes) {

        InquirySimpleBbsDTO dto = new InquirySimpleBbsDTO();
        dto.setInquiry_title(inquiryTitle);
        dto.setInquiry_content(inquiryContent);
        dto.setUser_nick(userNick);  // 닉네임 설정
        
        try {
            int result = boardService.writePost(dto, inquiryOfile, inquirySfile);
            if (result <= 0) {
                throw new RuntimeException("Post writing failed");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/error?message=fileUploadFailed";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/error?message=dataWriteFailed";
        }
        
        return "redirect:/Admin/inquiry/inquiryList";
    }

    
    @GetMapping("/Member/inquiry/inquiryView")
    public String boardView(Model model, @RequestParam("inquiry_num") String inquiryNum, HttpSession session) {
        
        Long inquiryNumLong = Long.parseLong(inquiryNum); 
        // 사용자 닉네임 가져오기
        String userNick = (String) session.getAttribute("userNick");
        
        InquirySimpleBbsDTO inquirysimplebbsDTO = new InquirySimpleBbsDTO();
        inquirysimplebbsDTO.setInquiry_num(inquiryNum);

        // 게시물 조회 및 조회수 증가
        boardService.incrementVisitCount(inquiryNum);
        inquirysimplebbsDTO = boardService.getBoardView(inquirysimplebbsDTO);
        inquirysimplebbsDTO.setInquiry_content(inquirysimplebbsDTO.getInquiry_content().replace("\r\n", "<br/>"));

        // 좋아요 개수 조회
        int likeCount = inquiryLikeService.getLikeCount(inquiryNumLong);
        inquirysimplebbsDTO.setLikeCount(likeCount);
        
        // 현재 사용자의 좋아요 상태 확인
        boolean userLiked = inquiryLikeService.isLiked(inquiryNumLong, userNick);
        
        // 댓글 조회
        List<inquiryCommentDTO> comments = commentService.getCommentsByInquiryNum(inquiryNum);
        
        // 댓글 수 계산
        int commentCount = comments.size();

        // 모델에 데이터 추가
        model.addAttribute("inquirysimplebbsDTO", inquirysimplebbsDTO);
        model.addAttribute("comments", comments);
        model.addAttribute("commentCount", commentCount);
        model.addAttribute("userLiked", userLiked); // 추가된 부분

        return "/Member/inquiry/inquiryView";
    } 
    
    
    @GetMapping("/Admin/inquiry/inquiryView")
    public String AdminboardView(Model model, @RequestParam("inquiry_num") String inquiryNum, HttpSession session) {
        
        Long inquiryNumLong = Long.parseLong(inquiryNum); 
        // 사용자 닉네임 가져오기
        String userNick = (String) session.getAttribute("userNick");
        
        InquirySimpleBbsDTO inquirysimplebbsDTO = new InquirySimpleBbsDTO();
        inquirysimplebbsDTO.setInquiry_num(inquiryNum);

        // 게시물 조회 및 조회수 증가
        boardService.incrementVisitCount(inquiryNum);
        inquirysimplebbsDTO = boardService.getBoardView(inquirysimplebbsDTO);
        inquirysimplebbsDTO.setInquiry_content(inquirysimplebbsDTO.getInquiry_content().replace("\r\n", "<br/>"));

        // 좋아요 개수 조회
        int likeCount = inquiryLikeService.getLikeCount(inquiryNumLong);
        inquirysimplebbsDTO.setLikeCount(likeCount);
        
        // 현재 사용자의 좋아요 상태 확인
        boolean userLiked = inquiryLikeService.isLiked(inquiryNumLong, userNick);
        
        // 댓글 조회
        List<inquiryCommentDTO> comments = commentService.getCommentsByInquiryNum(inquiryNum);
        
        // 댓글 수 계산
        int commentCount = comments.size();

        // 모델에 데이터 추가
        model.addAttribute("inquirysimplebbsDTO", inquirysimplebbsDTO);
        model.addAttribute("comments", comments);
        model.addAttribute("commentCount", commentCount);
        model.addAttribute("userLiked", userLiked); // 추가된 부분

        return "/Admin/inquiry/inquiryView";
    } 
    
    
    
    @PostMapping("/inquiry/addLike")
    public String addLike(@RequestParam("iquiry_num") Long inquiryNum,
                          @SessionAttribute("userNick") String userNick) {
    	inquiryLikeService.addLike(inquiryNum, userNick);
        return "redirect:/Member/inquiry/inquiryView?inquiry_num=" + inquiryNum;
    }

    @PostMapping("/inquiry/removeLike")
    public String removeLike(@RequestParam("inquiry_num") Long inquiryNum,
                             @SessionAttribute("userNick") String userNick) {
    	inquiryLikeService.removeLike(inquiryNum, userNick);
        return "redirect:/Member/inquiry/inquiryView?inquiry_num=" + inquiryNum;
    }
    
    @PostMapping("/inquiry/toggleLike")
    @ResponseBody
    public Map<String, Object> toggleLike(@RequestParam("inquiryNum") Long inquiryNum,
                                           @RequestParam("userNick") String userNick) {
        boolean userLiked = inquiryLikeService.isLiked(inquiryNum, userNick);

        if (userLiked) {
        	inquiryLikeService.removeLike(inquiryNum, userNick);
        } else {
        	inquiryLikeService.addLike(inquiryNum, userNick);
        }

        int likeCount = inquiryLikeService.getLikeCount(inquiryNum);

        Map<String, Object> response = new HashMap<>();
        response.put("likeCount", likeCount);
        response.put("userLiked", !userLiked); // 응답에 토글된 상태 포함

        return response;
    }
    
    
    @GetMapping("/inquiry/likeUsers")
    @ResponseBody
    public List<String> getLikeUsers(@RequestParam("inquiryNum") Long inquiryNum) {
        return inquiryLikeService.getLikeUsers(inquiryNum);
    }

    @PostMapping("/Member/inquiry/addComment")
    public String addComment(inquiryCommentDTO inquirycommentDTO, @RequestParam("inquiry_num") String inquiryNum, @SessionAttribute("userNick") String userNick) {
        inquirycommentDTO.setInquiry_num(inquiryNum);
        inquirycommentDTO.setUser_nick(userNick);
        commentService.addComment(inquirycommentDTO);
        return "redirect:/Member/inquiry/inquiryView?inquiry_num=" + inquiryNum;
    }
    
    @PostMapping("/Admin/inquiry/addComment")
    public String AdminaddComment(inquiryCommentDTO inquirycommentDTO, @RequestParam("inquiry_num") String inquiryNum, @SessionAttribute("userNick") String userNick) {
        inquirycommentDTO.setInquiry_num(inquiryNum);
        inquirycommentDTO.setUser_nick(userNick);
        commentService.addComment(inquirycommentDTO);
        return "redirect:/Admin/inquiry/inquiryView?inquiry_num=" + inquiryNum;
    }
    
    @PostMapping("/Member/inquiry/inquirydeleteComment")
    public String deleteComment(
            @RequestParam("inquiry_comment_id") int commentId, 
            @SessionAttribute("userNick") String userNick, 
            @SessionAttribute("userId") String userId, 
            @RequestParam("inquiry_num") String inquiryNum) {
        
        // 로그로 파라미터 값을 확인
        System.out.println("Comment ID: " + commentId);
        System.out.println("User Nick: " + userNick);
        System.out.println("User ID: " + userId);
        System.out.println("Inquiry Number: " + inquiryNum);
        
        // 댓글 정보 가져오기
        inquiryCommentDTO commentDTO = commentService.getinquiryCommentById(commentId);
        
        // 로그로 댓글 정보 확인
        if (commentDTO != null) {
            System.out.println("Comment Owner: " + commentDTO.getUser_nick());
        } else {
            System.out.println("Comment not found.");
        }

        // 댓글 삭제 권한 확인 및 삭제
        if (commentDTO != null && (userNick.equals(commentDTO.getUser_nick()) || "Admin".equals(userId))) {
            commentService.inquirydeleteComment(commentId);
        } else {
            // 권한이 없거나 댓글이 없을 경우 처리
            System.out.println("Unauthorized or Comment not found.");
        }

        // 리다이렉트
        return "redirect:/Member/inquiry/inquiryView?inquiry_num=" + inquiryNum;
    }
    
    @PostMapping("/Admin/inquirydeleteComment")
    public String AdmindeleteComment(
            @RequestParam("inquiry_comment_id") int commentId, 
            @SessionAttribute("userNick") String userNick, 
            @SessionAttribute("userId") String userId, 
            @RequestParam("inquiry_num") String inquiryNum) {
        
        // 로그로 파라미터 값을 확인
        System.out.println("Comment ID: " + commentId);
        System.out.println("User Nick: " + userNick);
        System.out.println("User ID: " + userId);
        System.out.println("Inquiry Number: " + inquiryNum);
        
        // 댓글 정보 가져오기
        inquiryCommentDTO commentDTO = commentService.getinquiryCommentById(commentId);
        
        // 로그로 댓글 정보 확인
        if (commentDTO != null) {
            System.out.println("Comment Owner: " + commentDTO.getUser_nick());
        } else {
            System.out.println("Comment not found.");
        }

        // 댓글 삭제 권한 확인 및 삭제
        if (commentDTO != null && (userNick.equals(commentDTO.getUser_nick()) || "Admin".equals(userId))) {
            commentService.inquirydeleteComment(commentId);
        } else {
            // 권한이 없거나 댓글이 없을 경우 처리
            System.out.println("Unauthorized or Comment not found.");
        }

        // 리다이렉트
        return "redirect:/Admin/inquiry/inquiryView?inquiry_num=" + inquiryNum;
    }
    
    

    @GetMapping("/inquiryDownload")
    public ResponseEntity<Resource> downloadFile(
        @RequestParam("inquiry_ofile") String inquiryOfile,
        @RequestParam("inquiry_sfile") String inquirySfile,
        @RequestParam("inquiry_num") String inquiryNum,
        InquirySimpleBbsDTO inquirysimplebbsDTO) {

        // 파일 존재 여부 체크
        if (inquiryOfile == null || inquiryOfile.isEmpty()) {
            // 파일이 없는 경우 처리
            return ResponseEntity.notFound().build();
        }

        boardService.incrementDownCount(inquiryNum);
        
        return fileDownService.downloadFile(inquiryOfile, inquirySfile);
    }

    @GetMapping("/Member/inquiry/inquiryEdit")
    public String boardEditGet(Model model, InquirySimpleBbsDTO inquirysimplebbsDTO) {
        inquirysimplebbsDTO = boardService.getBoardView(inquirysimplebbsDTO);
        model.addAttribute("inquirysimplebbsDTO", inquirysimplebbsDTO);
        
        return "/Member/inquiry/inquiryEdit";
    }
    
    @GetMapping("/Admin/inquiryEdit")
    public String AdminboardEditGet(Model model, InquirySimpleBbsDTO inquirysimplebbsDTO) {
        inquirysimplebbsDTO = boardService.getBoardView(inquirysimplebbsDTO);
        model.addAttribute("inquirysimplebbsDTO", inquirysimplebbsDTO);
        
        return "/Admin/inquiry/inquiryEdit";
    }
   
    @PostMapping("/inquiryEdit")
    public String boardEditPost(@RequestParam(name = "userNick") String userNick,
            @RequestParam("inquiry_num") String inquiryNum,
            @RequestParam("inquiry_title") String inquiryTitle,
            @RequestParam("inquiry_content") String inquiryContent,
            @RequestParam(value = "inquiry_ofile", required = false) MultipartFile inquiryOfile,
            @RequestParam("prevOfile") String prevOfile,
            HttpServletRequest request) {

        InquirySimpleBbsDTO dto = new InquirySimpleBbsDTO();
        dto.setInquiry_num(inquiryNum);
        dto.setInquiry_title(inquiryTitle);
        dto.setInquiry_content(inquiryContent);
        dto.setUser_nick(userNick);
        
        try {
            int result = boardService.editPost(dto, inquiryOfile, prevOfile);
            if (result <= 0) {
                throw new RuntimeException("Post editing failed");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/error?message=fileUploadFailed";
        } catch (Exception e) {
            e.printStackTrace();  // 다른 예외 처리
            return "redirect:/error?message=unexpectedError";
        }
        
        return "redirect:/Member/inquiry/inquiryView?inquiry_num=" + inquiryNum;
    }
    
    @PostMapping("/Admin/inquiryEdit")
    public String AdminboardEditPost(@RequestParam(name = "userNick") String userNick,
            @RequestParam("inquiry_num") String inquiryNum,
            @RequestParam("inquiry_title") String inquiryTitle,
            @RequestParam("inquiry_content") String inquiryContent,
            @RequestParam(value = "inquiry_ofile", required = false) MultipartFile inquiryOfile,
            @RequestParam("prevOfile") String prevOfile,
            HttpServletRequest request) {

        InquirySimpleBbsDTO dto = new InquirySimpleBbsDTO();
        dto.setInquiry_num(inquiryNum);
        dto.setInquiry_title(inquiryTitle);
        dto.setInquiry_content(inquiryContent);
        dto.setUser_nick(userNick);
        
        try {
            int result = boardService.editPost(dto, inquiryOfile, prevOfile);
            if (result <= 0) {
                throw new RuntimeException("Post editing failed");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/error?message=fileUploadFailed";
        } catch (Exception e) {
            e.printStackTrace();  // 다른 예외 처리
            return "redirect:/error?message=unexpectedError";
        }
        
        return "redirect:/Admin/inquiry/inquiryView?inquiry_num=" + inquiryNum;
    }
    

    @PostMapping("/Member/inquiry/inquiryDelete")
    public String boardDeletePost(HttpServletRequest req) {
        int result = boardService.inquirydeletePost(req.getParameter("inquiry_num"));
        System.out.println("글삭제결과:" + result);
        
        return "redirect:/Member/inquiry/inquiryList";
    }
    
    @PostMapping("/Admin/inquiryDelete")
    public String AdminboardDeletePost(HttpServletRequest req) {
        int result = boardService.inquirydeletePost(req.getParameter("inquiry_num"));
        System.out.println("글삭제결과:" + result);
        
        return "redirect:/Admin/inquiry/inquiryList";
    }
    
    
}
package com.popup.project.board.promotion.controller;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.popup.project.board.promotion.dto.PromotionParameterDTO;
import com.popup.project.board.promotion.dto.PromotionBoardDTO;
import com.popup.project.board.promotion.dto.PromotionCommentDTO;
import com.popup.project.board.promotion.service.PromotionBoardService;
import com.popup.project.board.promotion.service.PromotionFileDownService;
import com.popup.project.board.promotion.service.PromotionPagingService;
import com.popup.project.board.promotion.service.PromotionLikeService;
import com.popup.project.board.promotion.service.PromotionCommentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PromotionController {

    @Autowired
    private PromotionBoardService boardService;
    
    @Autowired
    private PromotionFileDownService fileDownService;
    
    @Autowired
    private PromotionPagingService pagingService;
    
    @Autowired
    private PromotionCommentService promotioncommentService;
    
    @Autowired
    private PromotionLikeService promotionLikeService;

    @RequestMapping("/promotionList")
    public String boardList(Model model, HttpServletRequest req, PromotionParameterDTO parameterDTO) {
        int totalCount = boardService.getTotalCount(parameterDTO);
        int pageNum = (req.getParameter("pageNum") == null || req.getParameter("pageNum").equals("")) ? 1 : Integer.parseInt(req.getParameter("pageNum"));

        int start = (pageNum - 1) * PromotionPagingService.PAGE_SIZE + 1;
        int end = pageNum * PromotionPagingService.PAGE_SIZE;
        parameterDTO.setStart(start);
        parameterDTO.setEnd(end);

        Map<String, Object> maps = new HashMap<>();
        maps.put("totalCount", totalCount);
        maps.put("pageSize", PromotionPagingService.PAGE_SIZE);
        maps.put("pageNum", pageNum);
        model.addAttribute("maps", maps);

        model.addAttribute("lists", boardService.getBoardList(parameterDTO));

        String searchField = req.getParameter("searchField");
        String searchKeyword = req.getParameter("searchKeyword");

        String pagingImg = pagingService.generatePaging(totalCount, pageNum, req.getContextPath() + "/promotionList?", searchField, searchKeyword);
        model.addAttribute("pagingImg", pagingImg);

        model.addAttribute("searchField", searchField);
        model.addAttribute("searchKeyword", searchKeyword);

        return "/Member/promotion/promotionList";
    }

    @GetMapping("/promotionWrite")
    public String boardWriteGet(Model model) {
        return "/Member/promotion/promotionWrite";
    }

    @PostMapping("/promotionWrite")
    public String writePost(@RequestParam(name = "userNick") String userNick,
            @RequestParam("promotion_title") String promotionTitle,
            @RequestParam("promotion_content") String promotionContent,
            @RequestParam(value = "promotion_ofile", required = false) MultipartFile promotionOfile,
            @RequestParam(value = "promotion_sfile", required = false) MultipartFile promotionSfile,
            RedirectAttributes redirectAttributes) {

        PromotionBoardDTO dto = new PromotionBoardDTO();
        dto.setPromotion_title(promotionTitle);
        dto.setPromotion_content(promotionContent);
        dto.setUser_nick(userNick);  // 닉네임 설정
        
        try {
            int result = boardService.writePost(dto, promotionOfile, promotionSfile);
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

        return "redirect:/promotionList";
    }

    @GetMapping("/promotionView")
    public String boardView(Model model, @RequestParam("promotion_num") String promotionNum, HttpSession session) {
        // PromotionNum을 Long으로 변환
        Long promotionNumLong = Long.parseLong(promotionNum); 
        // 사용자 닉네임 가져오기
        String userNick = (String) session.getAttribute("userNick");
        
        PromotionBoardDTO simplebbsDTO = new PromotionBoardDTO();
        simplebbsDTO.setPromotion_num(promotionNum);

        // 게시물 조회 및 조회수 증가
        boardService.incrementVisitCount(promotionNum);
        simplebbsDTO = boardService.getBoardView(simplebbsDTO);
        simplebbsDTO.setPromotion_content(simplebbsDTO.getPromotion_content().replace("\r\n", "<br/>"));

	    // 좋아요 개수 조회
        int likeCount = promotionLikeService.getLikeCount(Long.parseLong(promotionNum));
        simplebbsDTO.setLikeCount(likeCount);
        // 현재 사용자의 좋아요 상태 확인
        boolean userLiked = promotionLikeService.isLiked(promotionNumLong, userNick);
        
        // 댓글 조회
        List<PromotionCommentDTO> comments = promotioncommentService.getCommentsByPromotionNum(promotionNum);

        // 댓글 수 계산
        int commentCount = comments.size();
        
        model.addAttribute("simplebbsDTO", simplebbsDTO);
        model.addAttribute("comments", comments);
        model.addAttribute("commentCount", commentCount);
        model.addAttribute("userLiked", userLiked);
        return "Member/promotion/promotionView";
    }
    
    @PostMapping("/promotion/addLike")
    public String addLike(@RequestParam("promotion_num") Long promotionNum,
                          @SessionAttribute("userNick") String userNick) {
        promotionLikeService.addLike(promotionNum, userNick);
        return "redirect:/promotionView?promotion_num=" + promotionNum;
    }

    @PostMapping("/promotion/removeLike")
    public String removeLike(@RequestParam("promotion_num") Long promotionNum,
                             @SessionAttribute("userNick") String userNick) {
        promotionLikeService.removeLike(promotionNum, userNick);
        return "redirect:/promotionView?promotion_num=" + promotionNum;
    }
    
    @PostMapping("/promotion/toggleLike")
    @ResponseBody
    public Map<String, Object> toggleLike(@RequestParam("promotionNum") Long promotionNum,
                                           @RequestParam("userNick") String userNick) {
        boolean userLiked = promotionLikeService.isLiked(promotionNum, userNick);

        if (userLiked) {
            promotionLikeService.removeLike(promotionNum, userNick);
        } else {
            promotionLikeService.addLike(promotionNum, userNick);
        }

        int likeCount = promotionLikeService.getLikeCount(promotionNum);

        Map<String, Object> response = new HashMap<>();
        response.put("likeCount", likeCount);
        response.put("userLiked", !userLiked); // 응답에 토글된 상태 포함

        return response;
    }
    
    @PostMapping("/promotion/promotionaddComment")
    public String addComment(PromotionCommentDTO protmotioncommentDTO, @RequestParam("promotion_num") String promotionNum, @SessionAttribute("userNick") String userNick) {
    	protmotioncommentDTO.setPromotion_num(promotionNum);
    	protmotioncommentDTO.setUser_nick(userNick);
    	promotioncommentService.promotionaddComment(protmotioncommentDTO);
        return "redirect:/promotionView?promotion_num=" + promotionNum;
    }
   
    @PostMapping("/promotion/promotiondeleteComment")
    public String promotiondeleteComment(@RequestParam("promotion_comment_id") int commentId, @SessionAttribute("userNick") String userNick, @SessionAttribute("userId") String userId, @RequestParam("promotion_num") String promotionNum) {
        // 댓글 작성자 또는 관리자만 삭제할 수 있도록 확인
        PromotionCommentDTO commentDTO = promotioncommentService.getpromotionCommentById(commentId);
        
        if (commentDTO != null && (userNick.equals(commentDTO.getUser_nick()) || "Admin".equals(userId))) {
        	promotioncommentService.promotiondeleteComment(commentId);
        }
        
        return "redirect:/promotionView?promotion_num=" + promotionNum;
    }
    

    @GetMapping("/promotionDownload")
    public ResponseEntity<Resource> downloadFile(
        @RequestParam("promotion_ofile") String promotionOfile,
        @RequestParam("promotion_sfile") String promotionSfile,
        @RequestParam("promotion_num") String promotionNum,
        PromotionBoardDTO simplebbsDTO) {

        // 파일 존재 여부 체크
        if (promotionOfile == null || promotionOfile.isEmpty()) {
            // 파일이 없는 경우 처리
            return ResponseEntity.notFound().build();
        }

        boardService.incrementDownCount(promotionNum);
        
        return fileDownService.downloadFile(promotionOfile, promotionSfile);
    }

    @GetMapping("/promotionEdit")
    public String boardEditGet(Model model, PromotionBoardDTO simplebbsDTO) {
        simplebbsDTO = boardService.getBoardView(simplebbsDTO);
        model.addAttribute("simplebbsDTO", simplebbsDTO);
        return "Member/promotion/promotionEdit";
    }

    @PostMapping("/promotionEdit")
    public String boardEditPost(@RequestParam(name = "userNick") String userNick,
            @RequestParam("promotion_num") String promotionNum,
            @RequestParam("promotion_title") String promotionTitle,
            @RequestParam("promotion_content") String promotionContent,
            @RequestParam(value = "promotion_ofile", required = false) MultipartFile promotionOfile,
            @RequestParam("prevOfile") String prevOfile,
            HttpServletRequest request) {
    	
    	

        PromotionBoardDTO dto = new PromotionBoardDTO();
        dto.setPromotion_num(promotionNum);
        dto.setPromotion_title(promotionTitle);
        dto.setPromotion_content(promotionContent);
        dto.setUser_nick(userNick);

        try {
            int result = boardService.editPost(dto, promotionOfile, prevOfile);
            if (result <= 0) {
                throw new RuntimeException("Post editing failed");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/error?message=fileUploadFailed";
        }

        return "redirect:/promotionView?promotion_num=" + promotionNum;
    }

    @PostMapping("/promotionDelete")
    public String boardDeletePost(HttpServletRequest req) {
        int result = boardService.promotiondeletePost(req.getParameter("promotion_num"));
        System.out.println("글삭제결과:" + result);
        return "redirect:/promotionList";
    }
}
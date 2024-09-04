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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.popup.project.board.promotion.dto.PromotionBoardDTO;
import com.popup.project.board.promotion.dto.PromotionCommentDTO;
import com.popup.project.board.promotion.dto.PromotionParameterDTO;
import com.popup.project.board.promotion.service.PromotionBoardService;
import com.popup.project.board.promotion.service.PromotionCommentService;
import com.popup.project.board.promotion.service.PromotionFileDownService;
import com.popup.project.board.promotion.service.PromotionLikeService;
import com.popup.project.board.promotion.service.PromotionPagingService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/{role}")
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
    
    private String getRolePath(String role) {
        return role.substring(0, 1).toUpperCase() + role.substring(1).toLowerCase(); // Convert to "Member"
    }

    @GetMapping("/promotionList")
    public String boardList(@PathVariable("role") String role, Model model, HttpServletRequest req, PromotionParameterDTO parameterDTO) {
    	String rolePath = getRolePath(role);
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

        String pagingImg = pagingService.generatePaging(totalCount, pageNum, req.getContextPath() + "/" + rolePath + "/promotion/promotionList?", searchField, searchKeyword);
        model.addAttribute("pagingImg", pagingImg);

        model.addAttribute("searchField", searchField);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("role", role);
        

        return "/" + rolePath + "/promotion/promotionList";  // 역할에 따라 다른 경로로 리턴
    }

    @GetMapping("/promotionWrite")
    public String boardWriteGet(@PathVariable("role") String role, Model model) {
    	String rolePath = getRolePath(role);
    	model.addAttribute("role", rolePath);
        return "/" + rolePath + "/promotion/promotionWrite";  // 역할에 따라 다른 경로로 리턴
    }

    @PostMapping("/promotionWrite")
    public String writePost(@PathVariable("role") String role,
                            @RequestParam(name = "userNick") String userNick,
                            @RequestParam("promotion_title") String promotionTitle,
                            @RequestParam("promotion_content") String promotionContent,
                            @RequestParam(value = "promotion_ofile", required = false) MultipartFile promotionOfile,
                            @RequestParam(value = "promotion_sfile", required = false) MultipartFile promotionSfile,
                            RedirectAttributes redirectAttributes) {
    	
    	String rolePath = getRolePath(role);

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
            return "redirect:/" + rolePath + "/error?message=fileUploadFailed";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/" + rolePath + "/error?message=dataWriteFailed";
        }

        return "redirect:/" + rolePath + "/promotionList";  // 역할에 따라 다른 경로로 리턴
    }

    @GetMapping("/promotionView")
    public String boardView(@PathVariable("role") String role, Model model, @RequestParam("promotion_num") String promotionNum, HttpSession session) {
    	
    	String rolePath = getRolePath(role);
        Long promotionNumLong = Long.parseLong(promotionNum); 
        String userNick = (String) session.getAttribute("userNick");
        
        PromotionBoardDTO simplebbsDTO = new PromotionBoardDTO();
        simplebbsDTO.setPromotion_num(promotionNum);

        boardService.incrementVisitCount(promotionNum);
        simplebbsDTO = boardService.getBoardView(simplebbsDTO);
        simplebbsDTO.setPromotion_content(simplebbsDTO.getPromotion_content().replace("\r\n", "<br/>"));

        int likeCount = promotionLikeService.getLikeCount(promotionNumLong);
        simplebbsDTO.setLikeCount(likeCount);
        boolean userLiked = promotionLikeService.isLiked(promotionNumLong, userNick);
        
        List<PromotionCommentDTO> comments = promotioncommentService.getCommentsByPromotionNum(promotionNum);
        int commentCount = comments.size();
        
        model.addAttribute("simplebbsDTO", simplebbsDTO);
        model.addAttribute("comments", comments);
        model.addAttribute("commentCount", commentCount);
        model.addAttribute("userLiked", userLiked);

        return "/" + rolePath + "/promotion/promotionView";
    }

    @PostMapping("/promotion/addLike")
    public String addLike(@PathVariable("role") String role,
                          @RequestParam("promotion_num") Long promotionNum,
                          @SessionAttribute("userNick") String userNick) {
    	
    	String rolePath = getRolePath(role);
        promotionLikeService.addLike(promotionNum, userNick);
        return "redirect:/" + rolePath + "/promotion/promotionView?promotion_num=" + promotionNum;
    }

    @PostMapping("/promotion/removeLike")
    public String removeLike(@PathVariable("role") String role,
                             @RequestParam("promotion_num") Long promotionNum,
                             @SessionAttribute("userNick") String userNick) {
    	
    	String rolePath = getRolePath(role);
        promotionLikeService.removeLike(promotionNum, userNick);
        return "redirect:/" + rolePath + "/promotion/promotionView?promotion_num=" + promotionNum;
    }
    
    @PostMapping("/promotion/toggleLike")
    @ResponseBody
    public Map<String, Object> toggleLike(@PathVariable("role") String role,
                                           @RequestParam("promotionNum") Long promotionNum,
                                           @RequestParam("userNick") String userNick) {
    	String rolePath = getRolePath(role);
        boolean userLiked = promotionLikeService.isLiked(promotionNum, userNick);

        if (userLiked) {
            promotionLikeService.removeLike(promotionNum, userNick);
        } else {
            promotionLikeService.addLike(promotionNum, userNick);
        }

        int likeCount = promotionLikeService.getLikeCount(promotionNum);

        Map<String, Object> response = new HashMap<>();
        response.put("likeCount", likeCount);
        response.put("userLiked", !userLiked);

        return response;
    }
    
    @PostMapping("/promotion/promotionaddComment")
    public String addComment(@PathVariable("role") String role,
                             PromotionCommentDTO protmotioncommentDTO,
                             @RequestParam("promotion_num") String promotionNum,
                             @SessionAttribute("userNick") String userNick) {
    	
    	String rolePath = getRolePath(role);
        protmotioncommentDTO.setPromotion_num(promotionNum);
        protmotioncommentDTO.setUser_nick(userNick);
        promotioncommentService.promotionaddComment(protmotioncommentDTO);
        return "redirect:/" + rolePath + "/promotionView?promotion_num=" + promotionNum;
    }
   
    @PostMapping("/promotion/promotiondeleteComment")
    public String promotiondeleteComment(@PathVariable("role") String role,
                                         @RequestParam("promotion_comment_id") int commentId,
                                         @SessionAttribute("userNick") String userNick,
                                         @SessionAttribute("userId") String userId,
                                         @RequestParam("promotion_num") String promotionNum) {
    	
    	String rolePath = getRolePath(role);
        PromotionCommentDTO commentDTO = promotioncommentService.getpromotionCommentById(commentId);
        
        if (commentDTO != null && (userNick.equals(commentDTO.getUser_nick()) || "Admin".equals(userId))) {
            promotioncommentService.promotiondeleteComment(commentId);
        }
        
        return "redirect:/" + rolePath + "/promotionView?promotion_num=" + promotionNum;
    }

    @GetMapping("/promotionDownload")
    public ResponseEntity<Resource> downloadFile(@PathVariable("role") String role,
                                                 @RequestParam("promotion_ofile") String promotionOfile,
                                                 @RequestParam("promotion_sfile") String promotionSfile,
                                                 @RequestParam("promotion_num") String promotionNum,
                                                 PromotionBoardDTO simplebbsDTO) {
    	
    	String rolePath = getRolePath(role);

        if (promotionOfile == null || promotionOfile.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        boardService.incrementDownCount(promotionNum);
        
        return fileDownService.downloadFile(promotionOfile, promotionSfile);
    }

    @GetMapping("/promotionEdit")
    public String boardEditGet(@PathVariable("role") String role, Model model, PromotionBoardDTO simplebbsDTO) {
    	
    	String rolePath = getRolePath(role);
        simplebbsDTO = boardService.getBoardView(simplebbsDTO);
        model.addAttribute("simplebbsDTO", simplebbsDTO);
        return "/" + rolePath + "/promotion/promotionEdit";
    }

    @PostMapping("/promotionEdit")
    public String boardEditPost(@PathVariable("role") String role,
                                @RequestParam(name = "userNick") String userNick,
                                @RequestParam("promotion_num") String promotionNum,
                                @RequestParam("promotion_title") String promotionTitle,
                                @RequestParam("promotion_content") String promotionContent,
                                @RequestParam(value = "promotion_ofile", required = false) MultipartFile promotionOfile,
                                @RequestParam("prevOfile") String prevOfile,
                                HttpServletRequest request) {
    	
    	String rolePath = getRolePath(role);

        PromotionBoardDTO dto = new PromotionBoardDTO();
        dto.setPromotion_num(promotionNum);
        dto.setPromotion_title(promotionTitle);
        dto.setPromotion_content(promotionContent);
        dto.setUser_nick(userNick);  // 닉네임 설정

        try {
            int result = boardService.editPost(dto, promotionOfile, prevOfile, request);
            if (result <= 0) {
                throw new RuntimeException("Post editing failed");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/" + rolePath + "/error?message=fileUploadFailed";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/" + rolePath + "/error?message=dataUpdateFailed";
        }

        return "redirect:/" + rolePath + "/promotionList";
    }

    @PostMapping("/promotionDelete")
    public String boardDelete(@PathVariable("role") String role, @RequestParam("promotion_num") String promotionNum) {
    	
    	String rolePath = getRolePath(role);
        boardService.promotiondeletePost(promotionNum);
        return "redirect:/" + rolePath + "/promotionList";
    }
}
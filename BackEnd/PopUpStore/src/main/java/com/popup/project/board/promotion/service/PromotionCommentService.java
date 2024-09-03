package com.popup.project.board.promotion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popup.project.board.promotion.dto.PromotionCommentDTO;

@Service
public class PromotionCommentService {

    @Autowired
    private PromotionCommentMapper promotioncommentMapper;

    public void promotionaddComment(PromotionCommentDTO promotioncommentDTO) {
    	promotioncommentMapper.promotionaddComment(promotioncommentDTO);
    }

    public List<PromotionCommentDTO> getCommentsByPromotionNum(String promotionNum) {
        return promotioncommentMapper.getCommentsByPromotionNum(promotionNum);
    }
    
    public void promotiondeleteComment(int commentId) {
    	promotioncommentMapper.promotiondeleteComment(commentId);
    }
    public PromotionCommentDTO getpromotionCommentById(int commentId) {
        return promotioncommentMapper.getpromotionCommentById(commentId);
    }
}
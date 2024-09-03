package com.popup.project.board.promotion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popup.project.board.promotion.dto.promotionCommentDTO;

@Service
public class promotionCommentService {

    @Autowired
    private promotionCommentMapper promotioncommentMapper;

    public void promotionaddComment(promotionCommentDTO promotioncommentDTO) {
    	promotioncommentMapper.promotionaddComment(promotioncommentDTO);
    }

    public List<promotionCommentDTO> getCommentsByPromotionNum(String promotionNum) {
        return promotioncommentMapper.getCommentsByPromotionNum(promotionNum);
    }
    
    public void promotiondeleteComment(int commentId) {
    	promotioncommentMapper.promotiondeleteComment(commentId);
    }
    public promotionCommentDTO getpromotionCommentById(int commentId) {
        return promotioncommentMapper.getpromotionCommentById(commentId);
    }
}
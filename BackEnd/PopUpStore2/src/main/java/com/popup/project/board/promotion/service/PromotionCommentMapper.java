package com.popup.project.board.promotion.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.popup.project.board.promotion.dto.PromotionCommentDTO;

@Mapper
public interface PromotionCommentMapper {
    int promotionaddComment(PromotionCommentDTO commentDTO);

    List<PromotionCommentDTO> getCommentsByPromotionNum(String promotionNum);
    
    // 댓글 삭제 
    void promotiondeleteComment(int commentId);
    
    // 댓글 ID로 조회 
    PromotionCommentDTO getpromotionCommentById(int commentId);
    
}
package com.popup.project.board.promotion.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.popup.project.board.promotion.dto.promotionCommentDTO;

@Mapper
public interface promotionCommentMapper {
    int promotionaddComment(promotionCommentDTO commentDTO);

    List<promotionCommentDTO> getCommentsByPromotionNum(String promotionNum);
    
    // 댓글 삭제 
    void promotiondeleteComment(int commentId);
    
    // 댓글 ID로 조회 
    promotionCommentDTO getpromotionCommentById(int commentId);
    
}
package com.popup.project.board.inquiry.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.popup.project.board.inquiry.dto.inquiryCommentDTO;



@Mapper
public interface inquiryCommentMapper {
    int addComment(inquiryCommentDTO inquirycommentDTO);

    List<inquiryCommentDTO> getCommentsByInquiryNum(String inquiryNum);
    
 // 댓글 삭제 
    void inquirydeleteComment(int commentId);
    
    // 댓글 ID로 조회 
    inquiryCommentDTO getinquiryCommentById(int commentId);
}
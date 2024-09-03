package com.popup.project.board.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popup.project.board.inquiry.dto.inquiryCommentDTO;

@Service
public class inquiryCommentService {

    @Autowired
    private inquiryCommentMapper commentMapper;

    public void addComment(inquiryCommentDTO inquirycommentDTO) {
        commentMapper.addComment(inquirycommentDTO);
    }

    public List<inquiryCommentDTO> getCommentsByInquiryNum(String inquiryNum) {
        return commentMapper.getCommentsByInquiryNum(inquiryNum);
    }
    public void inquirydeleteComment(int commentId) {
    	commentMapper.inquirydeleteComment(commentId);
    }
    public inquiryCommentDTO getinquiryCommentById(int commentId) {
        return commentMapper.getinquiryCommentById(commentId);
    }
}
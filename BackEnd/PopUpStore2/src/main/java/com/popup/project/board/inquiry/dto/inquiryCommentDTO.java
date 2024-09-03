package com.popup.project.board.inquiry.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class inquiryCommentDTO {
    private int inquiry_comment_id;
    private String inquiry_num;
    private String user_nick;
    private String inquiry_comment_content;
    private Date created_at;
}
package com.popup.project.board.promotion.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PromotionCommentDTO {
    private int promotion_comment_id;
    private String promotion_num;
    private String user_nick;
    private String promotion_comment_content;
    private Date created_at;
}
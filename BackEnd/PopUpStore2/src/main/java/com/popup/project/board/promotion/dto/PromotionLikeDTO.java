package com.popup.project.board.promotion.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class PromotionLikeDTO {
    private Long likeId;
    private Long promotionNum;
    private String userNick;
    private LocalDate likeDate;
}

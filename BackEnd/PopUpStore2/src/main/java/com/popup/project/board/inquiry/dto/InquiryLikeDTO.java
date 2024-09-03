package com.popup.project.board.inquiry.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class InquiryLikeDTO {
    private Long likeId;
    private Long InquiryNum;
    private String userNick;
    private LocalDate likeDate;
}

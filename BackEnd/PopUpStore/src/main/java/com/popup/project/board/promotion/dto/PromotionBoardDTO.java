package com.popup.project.board.promotion.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PromotionBoardDTO
{
	private String promotion_num;
	private String user_nick;
	private String promotion_title;
	private String promotion_content;
	private Date promotion_create_date;   // 작성일
	private String promotion_ofile;    // 원본 파일명
	private String promotion_sfile;    // 저장된 파일명
	private int downcount;
	private int visitcount; // 조회수
	private int likeCount;
	
	
}

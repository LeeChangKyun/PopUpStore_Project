package com.popup.project.board.inquiry.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class InquirySimpleBbsDTO
{
	private String inquiry_num;
	private String user_nick;
	private String inquiry_title;
	private String inquiry_content;
	private Date inquiry_create_date;   // 작성일
	private String inquiry_ofile;    // 원본 파일명
	private String inquiry_sfile;    // 저장된 파일명
	private int downcount;
	private int visitcount; // 조회수
	private int likeCount;
	
	
}
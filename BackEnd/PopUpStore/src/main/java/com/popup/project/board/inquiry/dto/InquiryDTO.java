package com.popup.project.board.inquiry.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InquiryDTO {	
	private String searchField;  
	private String searchKeyword;
	private int start;		 
	private int end; 
}




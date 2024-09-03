package com.popup.project.board.review.model;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("ReviewLikes")
public class ReviewLikes { 

	public ReviewLikes() {}
	
    private int likeId; 
    private int reviewNum;
    private String userNick;
}

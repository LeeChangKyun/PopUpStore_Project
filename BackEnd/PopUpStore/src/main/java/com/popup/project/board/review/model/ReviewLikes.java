package com.popup.project.board.review.model;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("ReviewLikes")  // MyBatis에서 사용할 별칭 정의
public class ReviewLikes { 

	public ReviewLikes() {}
	
    private int likeId; 		// 좋아요 ID
    private int reviewNum;		// 리뷰 번호
    private String userNick;	// 닉네임
}

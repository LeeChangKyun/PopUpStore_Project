package com.popup.project.board.review.model;

import java.util.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("ReviewBoard") 
public class ReviewBoard {

	public ReviewBoard() {}
	
    private int reviewNum;
    private String reviewTitle;
    private String reviewContent;
    private String reviewOfile;
    private String reviewSfile;
    private Date reviewCreateDate;
    private int reviewViewcount;
    private int reviewLikecount;
    private ReviewUser user;
    private String userNick;
    private int commentCount;
    
    // userNick을 가져오는 getter
    public String getUserNick() {
        return this.user != null ? this.user.getUserNick() : this.userNick;
    }

    // userNick을 설정하는 setter
    public void setUserNick(String userNick) {
        this.userNick = userNick;
        if (this.user == null) {
            this.user = new ReviewUser();
        }
        this.user.setUserNick(userNick);
    }

    
    // 좋아요 수 증가
    public void incrementLikeCount() {
        this.reviewLikecount++;
    }

    // 좋아요 수 감소
    public void decrementLikeCount() {
        if (this.reviewLikecount > 0) {
            this.reviewLikecount--;
        }
    }
    
    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }
}

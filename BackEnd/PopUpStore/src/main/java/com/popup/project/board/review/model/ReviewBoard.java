package com.popup.project.board.review.model;

import java.util.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("ReviewBoard")  // MyBatis에서 사용할 별칭 정의
public class ReviewBoard {

	public ReviewBoard() {}
	
    private int reviewNum;			// 리뷰 번호
    private String reviewTitle;		// 리뷰 제목
    private String reviewContent;	// 리뷰 내용
    private String reviewOfile;		// 원본 파일명
    private String reviewSfile;		// 저장된 파일명
    private Date reviewCreateDate;	// 리뷰 작성일
    private int reviewViewcount;	// 리뷰 조회수
    private int reviewLikecount;	// 리뷰 좋아요 수
    private ReviewUser user;		// 작성자
    private String userNick;		// 닉네임
    private int commentCount;		// 댓글수 
    private String existingFile;	// 기존 파일명(게시글 수정시 업로드된 기존 파일)
    
    // 객체에 닉네임이 설정되어 있으면 해당 닉네임을 반환,
    //	그렇지 않으면 userNick 필드 값을 반환.
    public String getUserNick() {
        return this.user != null ? this.user.getUserNick() : this.userNick;
    }

    // 작성자의 닉네임을 설정
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

    // 좋아요 수 감소( - 값은 들어가지 않게)
    public void decrementLikeCount() {
        if (this.reviewLikecount > 0) {
            this.reviewLikecount--;
        }
    }
}

package com.popup.project.board.review.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("ReviewComment") // MyBatis에서 사용할 별칭 정의
public class ReviewComment {

    public ReviewComment() {}

    private int commentId;			// 댓글 ID
    private int reviewNum;			// 리뷰 번호
    private String userNick;		// 닉네임
    private String commentContent;  // 댓글 내용
    private String commentDate;     // 댓글 작성 날짜

    // 댓글 작성 날짜를 LocalDateTime 객체로 설정
    //	문자열로 변환하여 저장
    public void setCommentDateAsLocalDateTime(LocalDateTime dateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        this.commentDate = dateTime.format(formatter);
    }
    
    // 문자열로 저장된 commentDate를 LocalDateTime 객체로 변환하여 반환
    public LocalDateTime getCommentDateAsLocalDateTime() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return LocalDateTime.parse(this.commentDate, formatter);
    }

    // 형식화된 댓글 작성 날짜 문자열을 반환
    //	주로 뷰에서 직접 사용함
    public String getFormattedCommentDate() {
        return this.commentDate;  // 이미 형식화된 문자열이므로 그대로 반환
    }

    // 형식화된 댓글 작성 날짜 문자열을 설정
    public void setFormattedCommentDate(String formattedDate) {
        this.commentDate = formattedDate;  // 문자열로 저장
    }
}

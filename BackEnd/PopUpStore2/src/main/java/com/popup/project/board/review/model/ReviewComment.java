package com.popup.project.board.review.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("ReviewComment")
public class ReviewComment {

    public ReviewComment() {}

    private int commentId;
    private int reviewNum;
    private String userNick;
    private String commentContent;
    private String commentDate;  // LocalDateTime 대신 String으로 변경

    // 기존 LocalDateTime 관련 메서드들
    public void setCommentDateAsLocalDateTime(LocalDateTime dateTime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        this.commentDate = dateTime.format(formatter);
    }

    public LocalDateTime getCommentDateAsLocalDateTime() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return LocalDateTime.parse(this.commentDate, formatter);
    }

    // getFormattedCommentDate 메서드 추가
    public String getFormattedCommentDate() {
        return this.commentDate;  // 이미 형식화된 문자열이므로 그대로 반환
    }

    public void setFormattedCommentDate(String formattedDate) {
        this.commentDate = formattedDate;  // 문자열로 저장
    }
}

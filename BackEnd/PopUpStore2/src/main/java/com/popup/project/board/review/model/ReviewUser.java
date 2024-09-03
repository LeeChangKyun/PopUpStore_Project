package com.popup.project.board.review.model;

import java.util.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("ReviewUser")
public class ReviewUser {

	public ReviewUser() {}
	
    private String userNick;
    private String userId;
    private String userName;
    private String userPwd;
    private String userAddress;
    private Date userCreateDate;
}
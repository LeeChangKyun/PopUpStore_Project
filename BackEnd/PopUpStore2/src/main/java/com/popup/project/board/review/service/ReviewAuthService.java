package com.popup.project.board.review.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popup.project.board.review.model.ReviewUser;
import com.popup.project.board.review.model.ReviewUserMapper;

@Service
public class ReviewAuthService {

    @Autowired
    private ReviewUserMapper reviewUserMapper;

    public ReviewUser findByNick(String userNick) {
        return reviewUserMapper.findByUserNick(userNick);
    }

    public boolean authenticate(String userNick, String password) {
        ReviewUser user = reviewUserMapper.findByUserNick(userNick);
        return user != null && user.getUserPwd().equals(password);
    }
}

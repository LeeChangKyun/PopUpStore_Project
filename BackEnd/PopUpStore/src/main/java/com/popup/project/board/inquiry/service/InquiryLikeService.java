package com.popup.project.board.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InquiryLikeService {

    @Autowired
    private InquiryLikeMapper inquiryLikeMapper;
    


    public void addLike(Long inquiryNum, String userNick) {
        if (inquiryLikeMapper.checkLike(inquiryNum, userNick) == 0) {
        	inquiryLikeMapper.insertLike(inquiryNum, userNick);
        }
    }

    public void removeLike(Long inquiryNum, String userNick) {
        if (inquiryLikeMapper.checkLike(inquiryNum, userNick) > 0) {
        	inquiryLikeMapper.deleteLike(inquiryNum, userNick);
        }
    }

    public int getLikeCount(Long inquiryNum) {
        return inquiryLikeMapper.getLikeCount(inquiryNum);
    }

    public boolean isLiked(Long inquiryNum, String userNick) {
        return inquiryLikeMapper.checkLike(inquiryNum, userNick) > 0;
    }
    
    
    public List<String> getLikeUsers(Long inquiryNum) {
        return inquiryLikeMapper.getLikeUsers(inquiryNum);
    }
}
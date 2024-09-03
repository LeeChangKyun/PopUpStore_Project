package com.popup.project.board.promotion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PromotionLikeService {

    @Autowired
    private PromotionLikeMapper promotionLikeMapper;
    


    public void addLike(Long promotionNum, String userNick) {
        if (promotionLikeMapper.checkLike(promotionNum, userNick) == 0) {
            promotionLikeMapper.insertLike(promotionNum, userNick);
        }
    }

    public void removeLike(Long promotionNum, String userNick) {
        if (promotionLikeMapper.checkLike(promotionNum, userNick) > 0) {
            promotionLikeMapper.deleteLike(promotionNum, userNick);
        }
    }

    public int getLikeCount(Long promotionNum) {
        return promotionLikeMapper.getLikeCount(promotionNum);
    }

    public boolean isLiked(Long promotionNum, String userNick) {
        return promotionLikeMapper.checkLike(promotionNum, userNick) > 0;
    }
}
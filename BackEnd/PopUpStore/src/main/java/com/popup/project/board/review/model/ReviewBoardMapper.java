package com.popup.project.board.review.model;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReviewBoardMapper {

    int selectCount();

    List<ReviewBoard> selectListPage(@Param("start") int start, @Param("end") int end);

    ReviewBoard getPostById(int reviewNum);

    boolean confirmPassword(@Param("reviewPass") String reviewPass, @Param("reviewNum") int reviewNum);

    int deletePost(int reviewNum);

    int updatePost(ReviewBoard review);

    boolean isUserExists(String userNick);

    int insertWrite(ReviewBoard review);

    void incrementVisitCount(int reviewNum);
    
    void incrementLikeCount(int reviewNum);

    List<ReviewBoard> searchPostsByPage(
        @Param("searchField") String searchField,
        @Param("searchWord") String searchWord,
        @Param("start") int start,
        @Param("end") int end
    );

    int searchPostCount(
        @Param("searchField") String searchField,
        @Param("searchWord") String searchWord
    );
}

package com.popup.project.board.review.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface ReviewBoardMapper {

	// 게시글 전체 개수를 조회
    int selectCount();

    // 특정 페이지의 게시글 목록 조회
    List<ReviewBoard> selectListPage(@Param("start") int start, @Param("end") int end);

    // 특정 ID에 해당하는 게시글 조회
    ReviewBoard getPostById(int reviewNum);

    // 게시글 삭제
    int deletePost(int reviewNum);

    // 게시글 수정
    int updatePost(ReviewBoard review);

    // 특정 닉네임의 사용자가 존재하는지 확인
    boolean isUserExists(String userNick);

    // 게시글 작성
    int insertWrite(ReviewBoard review);

    // 조회수 증가
    void incrementVisitCount(int reviewNum);
    
    // 좋아요 수 증가
    void incrementLikeCount(int reviewNum);
    
    // 게시글의 파일 정보를 삭제(수정 페이지에서)
    int deleteFileInfo(@Param("reviewNum") int reviewNum);
    
    // 검색어와 필드에 따라 특정 페이지의 게시글을 검색하여 조회
    List<ReviewBoard> searchPostsByPage(
        @Param("searchField") String searchField,
        @Param("searchWord") String searchWord,
        @Param("start") int start,
        @Param("end") int end
    );

    // 검색어와 필드에 따라 검색된 게시글 전체 개수를 조회
    int searchPostCount(
        @Param("searchField") String searchField,
        @Param("searchWord") String searchWord
    );
}

CREATE TABLE REVIEWS_BOARD (
    review_num NUMBER NOT NULL,
    review_title VARCHAR2(100) NOT NULL,
    review_content VARCHAR2(1000) NOT NULL,
    review_ofile VARCHAR2(200),
    review_sfile VARCHAR2(200),
    review_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- 수정됨
    review_viewcount NUMBER DEFAULT 0 NOT NULL,
    review_likecount NUMBER DEFAULT 0 NOT NULL,
    user_nick VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_reviews PRIMARY KEY (review_num),
    CONSTRAINT fk_user_nick_reviews FOREIGN KEY (user_nick)
    REFERENCES USERS(user_nick)
    ON DELETE CASCADE
);

CREATE SEQUENCE seq_review_num
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- 댓글 테이블
CREATE TABLE REVIEWS_COMMENTS (
    comment_id NUMBER PRIMARY KEY,
    review_num NUMBER,
    user_nick VARCHAR2(100),
    comment_content VARCHAR2(1000),
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reviews_comments_reviews FOREIGN KEY (review_num)
    REFERENCES REVIEWS_BOARD(review_num)
    ON DELETE CASCADE
);

CREATE SEQUENCE seq_review_comment
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE OR REPLACE TRIGGER trg_seq_review_comment
BEFORE INSERT ON REVIEWS_COMMENTS
FOR EACH ROW
BEGIN
    SELECT seq_review_comment.NEXTVAL
    INTO :new.comment_id
    FROM dual;
END;
/

-- 좋아요 테이블
CREATE TABLE REVIEWS_LIKES (
    like_id NUMBER PRIMARY KEY,
    review_num NUMBER,
    user_nick VARCHAR2(100),
    CONSTRAINT fk_likes_user FOREIGN KEY (user_nick) REFERENCES USERS(user_nick),
    CONSTRAINT fk_likes_review FOREIGN KEY (review_num) REFERENCES REVIEWS_BOARD(review_num)
    ON DELETE CASCADE
);

CREATE SEQUENCE seq_like_id
START WITH 1
INCREMENT BY 1;

commit;



--DROP TABLE REVIEWS_COMMENTS;
--DROP SEQUENCE seq_review_comment;
--DROP TABLE REVIEWS_LIKES;
--DROP SEQUENCE seq_like_id;
--DROP TABLE REVIEWS_BOARD;
--DROP SEQUENCE seq_review_num;

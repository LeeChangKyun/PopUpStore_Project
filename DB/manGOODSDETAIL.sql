--CREATE TABLE GOODSDETAIL(
--	goods_price varchar2(100) PRIMARY KEY not null,
--	goods_image varchar2(1000) not null,
--	goodsdetail_quantity varchar2(100) not null,
--	goodsdetail_name varchar2(100) not null,
--    CONSTRAINT fk_goodsdetail_name FOREIGN KEY(goodsdetail_name) REFERENCES DETAIL(goodsdetail_name)
--    ON DELETE CASCADE
--);

-- 9/1 수정
CREATE TABLE GOODSDETAIL(
    goods_price VARCHAR2(100) PRIMARY KEY NOT NULL,  -- 기존 기본 키 유지
    goods_image VARCHAR2(1000) NOT NULL,
    goodsdetail_quantity VARCHAR2(100) NOT NULL,
    goodsdetail_name VARCHAR2(100) NOT NULL,
    UNIQUE (goodsdetail_name)  -- `goodsdetail_name`을 고유 키로 설정
);

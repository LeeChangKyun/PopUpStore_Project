--CREATE TABLE GOODS(
--	goods_name varchar2(100) PRIMARY KEY not null,
--	goods_image varchar2(1000) not null,
--	goods_price varchar2(100) not null,
--	CONSTRAINT fk_goods_price FOREIGN KEY(goods_price) REFERENCES GOODSDETAIL(goods_price)
--    ON DELETE CASCADE
--);

-- 9/1 수정
CREATE TABLE GOODS (
    goods_id NUMBER PRIMARY KEY,  -- 고유 ID (시퀀스와 트리거를 사용해 자동 증가하도록 설정)
    goods_name VARCHAR2(100) NOT NULL,  -- 상품 이름
    goods_image VARCHAR2(1000) NOT NULL,  -- 상품 이미지
    goods_price VARCHAR2(100) NOT NULL,  -- GOODSDETAIL의 가격을 참조
    goodsdetail_name VARCHAR2(100) NOT NULL,  -- GOODSDETAIL의 이름을 참조
    FOREIGN KEY (goods_price) REFERENCES GOODSDETAIL(goods_price)
        ON DELETE CASCADE,  -- GOODSDETAIL에서 삭제 시 관련 GOODS도 삭제
    FOREIGN KEY (goodsdetail_name) REFERENCES GOODSDETAIL(goodsdetail_name)
        ON DELETE CASCADE  -- GOODSDETAIL에서 삭제 시 관련 GOODS도 삭제
);

CREATE SEQUENCE goods_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE OR REPLACE TRIGGER goods_bi
BEFORE INSERT ON GOODS
FOR EACH ROW
BEGIN
    :NEW.goods_id := goods_seq.NEXTVAL;
END;
/

commit;

SELECT * 
FROM ALL_CONS_COLUMNS
WHERE TABLE_NAME = 'GOODS'
AND COLUMN_NAME = 'GOODS_ID';

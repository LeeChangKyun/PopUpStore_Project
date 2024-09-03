CREATE TABLE CART_ITEMS (
    cart_id NUMBER PRIMARY KEY,  -- 고유 ID
    user_id VARCHAR2(100) NOT NULL,  -- USERS 테이블의 외래 키
    goods_id NUMBER NOT NULL,  -- GOODS 테이블의 외래 키
    goods_quantity INT NOT NULL,  -- 상품 수량
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 장바구니에 추가된 시간
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
        ON DELETE CASCADE,  -- USERS에서 삭제 시 관련 CART_ITEMS도 삭제
    FOREIGN KEY (goods_id) REFERENCES GOODS(goods_id)
        ON DELETE CASCADE  -- GOODS에서 삭제 시 관련 CART_ITEMS도 삭제
);




CREATE SEQUENCE cart_id_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE OR REPLACE TRIGGER cart_items_bi
BEFORE INSERT ON CART_ITEMS
FOR EACH ROW
BEGIN
    :NEW.id := cart_items_seq.NEXTVAL;
END;
/

commit;

--DROP TABLE CART_ITEMS;
DROP SEQUENCE cart_id_seq;
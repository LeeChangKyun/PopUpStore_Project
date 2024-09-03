CREATE TABLE DETAIL(
	detail_photo varchar2(100) not null,
	detail_title varchar2(100) not null,
	detail_date varchar2(100) not null,
	detail_content varchar2(1000) not null,
	detail_address varchar2(200) not null,
	goodsdetail_name varchar2(100) PRIMARY KEY not null,
	detail_convenience1 varchar2(100) not null,
	detail_convenience2 varchar2(100) not null,
	detail_convenience3 varchar2(100) not null,
	detail_convenience4 varchar2(100) not null,
	category varchar2(100) not null,
	CONSTRAINT fk_category FOREIGN KEY(category) REFERENCES POPUP(category)
    ON DELETE CASCADE
);

DROP TABLE DETAIL;
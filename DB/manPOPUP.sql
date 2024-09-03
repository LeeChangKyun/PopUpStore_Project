CREATE TABLE POPUP(
	popup_location varchar2(100) not null,
	popup_address varchar2(200) not null,
	category varchar2(100) PRIMARY KEY not null,
	poopup_date varchar2(100) not null,
	popup_photo varchar2(100) not null,
	popup_content varchar2(1000) not null,
	popup_like varchar2(200) not null,
    popup_viewcount varchar2(200) not null
);

CREATE SEQUENCE POPUP_popup_viewcount
increment by 1
start with 1
minvalue 1
nomaxvalue
nocycle
nocache;

CREATE SEQUENCE POPUP_popup_like
increment by 1
start with 0
minvalue 0
nomaxvalue
nocycle
nocache;

DROP TABLE POPUP;
DROP SEQUENCE POPUP_popup_viewcount;
DROP SEQUENCE POPUP_popup_like;


CREATE TABLE EVENT_BOARD(
	event_title varchar2(100) not null,
	event_viewcount varchar2(200) not null,
	event_create_date DATE default sysdate not null,
	user_nick varchar2(100) not null,
    event_photo varchar2(1000),
	CONSTRAINT fk_user_nick_event FOREIGN KEY(user_nick) REFERENCES USERS(user_nick)
    ON DELETE CASCADE
);

CREATE SEQUENCE EVENT_event_viewcount
	increment by 1
	start with 1
	minvalue 1
	nomaxvalue
	nocycle
	nocache;


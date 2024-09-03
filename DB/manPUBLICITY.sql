CREATE TABLE PUBLICITY(
	publicity_num varchar2(100) not null,
	publicity_title varchar2(100) not null,
	publicity_content varchar2(1000) not null,
	publicity_create_date DATE default sysdate not null,
	user_nick varchar2(100) not null,
	CONSTRAINT fk_user_nick_publicity FOREIGN KEY(user_nick) REFERENCES USERS(user_nick)
    ON DELETE CASCADE
);

DROP TABLE PUBLICITY;
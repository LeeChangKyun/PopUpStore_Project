--CREATE SEQUENCE USERS_num
--increment by 1
--start with 1
--minvalue 1
--nomaxvalue
--nocycle
--nocache;

CREATE TABLE USERS(
    user_id varchar2(100) PRIMARY KEY not null,
    user_nick varchar2(100) UNIQUE not null,
    user_pwd varchar2(100) not null,
    user_name varchar2(100) not null,
    user_phone varchar2(100) not null,
    user_email varchar2(100) UNIQUE not null,
    user_zipcode varchar2(100) not null,
    user_address varchar2(200) not null,
    user_create_date DATE not null,
    authority varchar2(20) default 'ROLE_USER',
    enabled number(1) default 1,
    social_id varchar2(100), -- 소셜 로그인 ID (예: Google, Facebook ID)
    social_provider varchar2(50), -- 소셜 로그인 제공자 (예: google, facebook, naver 등)
    social_email varchar2(100), -- 소셜 로그인 이메일 (사용자 이메일과 다를 수 있음)
    failed_attempts NUMBER(5) DEFAULT 0,       -- 로그인 실패 시도 횟수
    account_locked NUMBER(1) DEFAULT 0 
);

SELECT * FROM USERS;      
    

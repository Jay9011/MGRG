
/* Drop Tables */

DROP TABLE holiday CASCADE CONSTRAINTS;
DROP TABLE office_hour CASCADE CONSTRAINTS;
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE department CASCADE CONSTRAINTS;
DROP TABLE positionrank CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_department_dep_uid;
DROP SEQUENCE SEQ_employees_emp_uid;
DROP SEQUENCE SEQ_holiday_h_uid;
DROP SEQUENCE SEQ_office_hour_w_uid;
DROP SEQUENCE SEQ_positionrank_p_uid;
DROP SEQUENCE SEQ_notice_n_uid;




/* Create Sequences */

CREATE SEQUENCE SEQ_department_dep_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_employees_emp_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_holiday_h_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_office_hour_w_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_positionrank_p_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_notice_n_uid INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE department
(
	dep_uid number NOT NULL,
	dep_name varchar2(60),
	PRIMARY KEY (dep_uid)
);


CREATE TABLE employees
(
	emp_uid number NOT NULL,
	emp_name varchar2(40) NOT NULL,
	emp_birthdate varchar2(10) NOT NULL,
	emp_phonenum number UNIQUE,
	emp_email varchar2(50) NOT NULL UNIQUE,
	emp_id varchar2(20) NOT NULL UNIQUE,
	emp_pw varchar2(20) NOT NULL,
	emp_addr clob,
	emp_hiredate date DEFAULT SYSDATE NOT NULL,
	emp_salary number NOT NULL,
	p_uid number NOT NULL,
	dep_uid number NOT NULL,
	PRIMARY KEY (emp_uid)
);


CREATE TABLE holiday
(
	h_uid number NOT NULL,
	h_start date NOT NULL,
	h_end date NOT NULL,
	emp_uid number NOT NULL,
	PRIMARY KEY (h_uid)
);


CREATE TABLE notice
(
	n_uid number NOT NULL,
	n_subject varchar2(100) NOT NULL,
	n_content clob NOT NULL,
	n_regdate date DEFAULT SYSDATE,
	dep_uid number,
	p_uid number NOT NULL,
	PRIMARY KEY (n_uid)
);


CREATE TABLE office_hour
(
	w_uid number NOT NULL,
	w_category varchar2(20),
	w_start date,
	w_end date,
	emp_uid number NOT NULL,
	PRIMARY KEY (w_uid)
);


CREATE TABLE positionrank
(
	p_uid number NOT NULL,
	p_name varchar2(30) NOT NULL UNIQUE,
	p_level number NOT NULL,
	p_holiday number NOT NULL,
	PRIMARY KEY (p_uid)
);



/* Create Foreign Keys */

ALTER TABLE employees
	ADD FOREIGN KEY (dep_uid)
	REFERENCES department (dep_uid)
;


ALTER TABLE notice
	ADD FOREIGN KEY (dep_uid)
	REFERENCES department (dep_uid)
;


ALTER TABLE holiday
	ADD FOREIGN KEY (emp_uid)
	REFERENCES employees (emp_uid)
;


ALTER TABLE office_hour
	ADD FOREIGN KEY (emp_uid)
	REFERENCES employees (emp_uid)
;


ALTER TABLE employees
	ADD FOREIGN KEY (p_uid)
	REFERENCES positionrank (p_uid)
;


ALTER TABLE notice
	ADD FOREIGN KEY (p_uid)
	REFERENCES positionrank (p_uid)
;


/* 부서 더미 */
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '인사부');
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '총무부');
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '경영지원부');
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '영업부');
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '기술부');

/* 직책 더미 */
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday) VALUES (SEQ_positionrank_p_uid.NEXTVAL, '사원', 1, 14);
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday) VALUES (SEQ_positionrank_p_uid.NEXTVAL, '대리', 2, 17);
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday) VALUES (SEQ_positionrank_p_uid.NEXTVAL, '팀장', 3, 20);
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday) VALUES (SEQ_positionrank_p_uid.NEXTVAL, '부장', 4, 22);
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday) VALUES (SEQ_positionrank_p_uid.NEXTVAL, '과장', 5, 24);
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday) VALUES (SEQ_positionrank_p_uid.NEXTVAL, '사장', 6, 27);
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday) VALUES (SEQ_positionrank_p_uid.NEXTVAL, '인사총괄', 7, 0);

/* 공지사항 더미 */
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '인-사휴가 관련 공지사항입니다.', '8월 7일부터는 휴가입니다.', to_date('2020-07-29', 'yyyy-mm-dd'),1,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '공-사 휴가 관련 공지사항입니다.', '8월 7일부터는 휴가입니다.',to_date('2020-07-29', 'yyyy-mm-dd'),1);
INSERT INTO notice (n_uid, n_subject, n_content, n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '공-대 휴가 관련 공지사항입니다.', '8월 7일부터는 휴가입니다.',to_date('2020-07-29', 'yyyy-mm-dd'),2);


/* 사원 더미 */

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '사사원', '1990/11/07', 'test@gmail.com', 'test', '123', 50000000, 1, 1);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '나사직', '1993/02/28', 'nasa@gmail.com', 'nasa', '123', 50000000, 1, 2);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '사지원', '1995/01/25', 'sup@gmail.com', 'sup', '123', 50000000, 1, 3);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '영업왕', '1894/11/14', 'king@gmail.com', 'king', '123', 50000000, 1, 4);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '공돌이', '1898/10/04', 'gong@gmail.com', 'gong', '123', 50000000, 1, 5);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '대대리', '1980/01/07', 'bald@gmail.com', 'bald', '123', 60000000, 2, 1);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '나팀장', '1983/12/08', 'team@gmail.com', 'team', '123', 70000000, 3, 2);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '사부장', '1978/01/25', 'sabu@gmail.com', 'sabu', '123', 80000000, 4, 3);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '과자앙', '1874/10/24', 'jjang@gmail.com', 'jjang', '123', 90000000, 5, 4);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '사장임', '1868/06/04', 'sajang@gmail.com', 'sajang', '123', 100000000, 6, 5);
;


/* SELECT */

SELECT * FROM EMPLOYEES ;
SELECT * FROM DEPARTMENT;
SELECT * FROM NOTICE;
SELECT * FROM POSITIONRANK;
SELECT n_uid "uid", n_subject subject, n_content content,n_regdate regdate,dep_uid department, p_uid "position"  FROM NOTICE;


-- 공통과 해당되는 부서의 목록보기
SELECT * FROM NOTICE WHERE (DEP_UID IS NULL OR DEP_UID = 1) AND P_UID <= 1;
SELECT n.n_uid "uid", n.n_subject subject, n.n_content content, n.n_regdate regdate, NVL(d.DEP_NAME, '공통') department, p.P_NAME "position" 
FROM NOTICE n JOIN DEPARTMENT d ON n.DEP_UID = d.DEP_UID(+) JOIN POSITIONRANK p ON n.P_UID =p.P_UID WHERE (d.DEP_UID IS NULL OR d.DEP_UID = 1) AND p.P_UID <= 1  ;

-- SELECT * FROM NOTICE WHERE (DEP_UID IS NULL OR DEP_UID = 2) AND P_UID = 2;

CREATE OR REPLACE VIEW NOTI AS SELECT
 n.n_uid "uid", n.n_subject subject, n.n_content content, n.n_regdate regdate, d.DEP_UID , NVL(d.DEP_NAME, '공통') department,p.P_UID ,p.P_NAME "position" 
FROM NOTICE n JOIN DEPARTMENT d ON n.DEP_UID = d.DEP_UID(+) JOIN POSITIONRANK p ON n.P_UID =p.P_UID;

CREATE OR REPLACE VIEW NOTI AS SELECT
 n.n_uid "uid", n.n_subject subject, n.n_content content, n.n_regdate regdate, NVL(d.DEP_UID, 0) dep_uid , NVL(d.DEP_NAME, '공통') department,p.P_UID p_uid,p.P_NAME "position" 
FROM NOTICE n JOIN DEPARTMENT d ON n.DEP_UID = d.DEP_UID(+) JOIN POSITIONRANK p ON n.P_UID =p.P_UID;

SELECT * FROM NOTI WHERE (DEP_UID =  0 OR DEP_UID = 1) AND P_UID <= 1  ;
SELECT * FROM NOTI;
DROP VIEW NOTI;



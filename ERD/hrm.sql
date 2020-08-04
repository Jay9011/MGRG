/* Drop Tables */
DROP TABLE holiday CASCADE CONSTRAINTS;
DROP TABLE office_hour CASCADE CONSTRAINTS;
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE department CASCADE CONSTRAINTS;
DROP TABLE positionrank CASCADE CONSTRAINTS;
DROP TABLE doc_table CASCADE CONSTRAINTS;

/* DROP VIEW */
DROP VIEW holi;
DROP VIEW NOTI;


/* Drop Sequences */
DROP SEQUENCE SEQ_department_dep_uid;
DROP SEQUENCE SEQ_employees_emp_uid;
DROP SEQUENCE SEQ_holiday_h_uid;
DROP SEQUENCE SEQ_office_hour_w_uid;
DROP SEQUENCE SEQ_positionrank_p_uid;
DROP SEQUENCE SEQ_notice_n_uid;
DROP SEQUENCE seq_uid;

/* Create Sequences */
CREATE SEQUENCE SEQ_department_dep_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_employees_emp_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_holiday_h_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_office_hour_w_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_positionrank_p_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_notice_n_uid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_uid;

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
	emp_birthdate date DEFAULT SYSDATE NOT NULL,
	emp_phonenum number UNIQUE,
	emp_email varchar2(50) NOT NULL UNIQUE,
	emp_id varchar2(20) NOT NULL UNIQUE,
	emp_pw varchar2(20) NOT NULL,
	emp_addr clob,
	emp_addrZoneCode clob,
	emp_addrRoad clob,
	emp_addrDetail clob,
	emp_hiredate date DEFAULT SYSDATE NOT NULL,
	emp_salary number NOT NULL,
	p_uid number NOT NULL,
	dep_uid number NOT NULL,
	enabled char(1) DEFAULT '1',
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
	w_start timestamp,
	w_end timestamp,
	emp_uid number NOT NULL,
	PRIMARY KEY (w_uid)
);


CREATE TABLE positionrank
(
	p_uid number NOT NULL,
	p_name varchar2(30) NOT NULL UNIQUE,
	p_level number NOT NULL,
	p_holiday number NOT NULL,
	p_auth varchar2(30) NOT NULL,
	PRIMARY KEY (p_uid)
);

CREATE TABLE doc_table
(
	doc_uid number NOT NULL,
	doc_title varchar2(30) NOT NULL,
	doc_content clob NULL,
	doc_file varchar2(80) NOT NULL,
	PRIMARY KEY (doc_uid)
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
	ON DELETE CASCADE
;

ALTER TABLE office_hour
	ADD FOREIGN KEY (emp_uid)
	REFERENCES employees (emp_uid)
	ON DELETE CASCADE
;

ALTER TABLE employees
	ADD FOREIGN KEY (p_uid)
	REFERENCES positionrank (p_uid)
;

ALTER TABLE notice
	ADD FOREIGN KEY (p_uid)
	REFERENCES positionrank (p_uid)
;

/* Create VIEW */
CREATE OR REPLACE VIEW NOTI AS SELECT
 n.n_uid "uid", n.n_subject subject, n.n_content content, n.n_regdate regdate, NVL(d.DEP_UID, 0) dep_uid , NVL(d.DEP_NAME, '공통') department,p.P_UID p_uid,p.P_NAME "position" 
FROM NOTICE n JOIN DEPARTMENT d ON n.DEP_UID = d.DEP_UID(+) JOIN POSITIONRANK p ON n.P_UID =p.P_UID;

/* 휴가 VIEW */
CREATE OR REPLACE VIEW holi AS
SELECT SUM("Day") "useHoliday", EMP_UID 
FROM (
	SELECT (h.H_END - h.H_START + 1) "Day", h.EMP_UID EMP_UID
	FROM HOLIDAY h 
	WHERE h.H_START BETWEEN TO_DATE(TO_CHAR(SYSDATE ,'YYYY') , 'YYYY') AND TO_DATE(TO_CHAR(SYSDATE ,'YYYY') + 1, 'YYYY')
)
GROUP BY EMP_UID 
;

/* 사원목록 VIEW */
CREATE OR REPLACE VIEW emp AS
SELECT e.EMP_UID "uid", e.EMP_NAME name, e.EMP_BIRTHDATE birthday, e.EMP_PHONENUM phonenum, e.EMP_EMAIL email, e.EMP_ID id, e.EMP_PW password, e.EMP_ADDRZONECODE addrZoneCode, e.EMP_ADDRROAD addrRoad, e.EMP_ADDRDETAIL addrDetail, e.EMP_HIREDATE hiredate, e.EMP_SALARY salary, p.P_UID p_uid, p.P_NAME "position", d.DEP_UID ,d.DEP_NAME department, NVL(h."useHoliday", 0) "useHoliday", p.P_HOLIDAY "total", (p.P_HOLIDAY - NVL(h."useHoliday", 0)) "leftHoliday"
FROM EMPLOYEES e LEFT OUTER JOIN DEPARTMENT d ON e.DEP_UID = d.DEP_UID 
				LEFT OUTER JOIN POSITIONRANK p ON e.P_UID = p.P_UID
				LEFT OUTER JOIN holi h ON e.EMP_UID = h.EMP_UID
;

-- 모든 직원들 출결 view로 만들어주기
CREATE OR REPLACE VIEW attendance AS 
SELECT e.EMP_UID "uid", e.EMP_NAME name, category.W_START "start", category.W_END "end", d.DEP_NAME posRank, p.P_NAME dept, category.stat "status", category.w_uid 
FROM DEPARTMENT d , POSITIONRANK p , EMPLOYEES e LEFT OUTER JOIN 
	(SELECT  
		h.*,
		CASE
			WHEN h.startTime IS NULL THEN '미출근'
			WHEN h.endTime < 1800 THEN '조퇴'
			WHEN h.startTime <= 900 AND h.endTime >= 1800 THEN '퇴근'
			WHEN h.endtime IS NULL AND h.startTime <= 900 THEN '출근'
			WHEN h.startTime > 900 THEN '지각'
			ELSE '결근'
			END AS stat
	FROM (SELECT e.emp_uid , oh.W_UID , oh.W_START , oh.W_END , TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
				 to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
			FROM (SELECT * FROM EMPLOYEES)e LEFT OUTER JOIN OFFICE_HOUR oh ON e.emp_uid = oh.EMP_UID 
			ORDER BY e.EMP_UID) h) category ON e.EMP_UID = category.EMP_UID
			WHERE e.DEP_UID = d.dep_uid AND e.P_UID = p.P_UID AND e.P_UID NOT IN (6, 7);


/* 부서 더미 */
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '인사부');
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '총무부');
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '경영지원부');
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '영업부');
INSERT INTO department (dep_uid, dep_name) VALUES (SEQ_department_dep_uid.nextval, '기술부');

/* 직책 더미 */
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday, p_auth) VALUES (1, '사원', 1, 14, 'ROLE_MEMBER');
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday, p_auth) VALUES (2, '대리', 2, 17, 'ROLE_MEMBER');
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday, p_auth) VALUES (3, '팀장', 3, 20, 'ROLE_MEMBER');
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday, p_auth) VALUES (4, '부장', 4, 22, 'ROLE_MEMBER');
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday, p_auth) VALUES (5, '과장', 5, 24, 'ROLE_MEMBER');
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday, p_auth) VALUES (6, '사장', 6, 27, 'ROLE_MEMBER');
INSERT INTO positionrank (p_uid, p_name, p_level, p_holiday, p_auth) VALUES (7, '인사총괄', 7, 0, 'ROLE_ADMIN');

/* 공지사항 더미 */
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/7)', '<h2><span style="color:#8e44ad;"><strong>8월 7일부터는 휴가입니다.</strong></span></h2><pre><span style="color:#e74c3c;"></span><span style="color:#f39c12;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/1)', '<h2><span style="color:#8e44ad;"><strong>8월 1일부터는 휴가입니다.</strong></span></h2><pre><span style="color:#e74c3c;"></span><span style="color:#f39c12;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/2)', '<h2><span style="color:#8e44ad;"><strong>8월 2일부터는 휴가입니다.</strong></span></h2><pre><span style="color:#e74c3c;"></span><span style="color:#f39c12;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/3)', '<h2><span style="color:#8e44ad;"><strong>8월 3일부터는 휴가입니다.</strong></span></h2><pre><span style="color:#e74c3c;"></span><span style="color:#f39c12;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/6)', '<h2><span style="color:#8e44ad;"><strong>8월 6일부터는 휴가입니다.</strong></span></h2><pre><span style="color:#e74c3c;"></span><span style="color:#f39c12;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),5);

INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-29', 'yyyy-mm-dd'),1,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-29', 'yyyy-mm-dd'),1,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-29', 'yyyy-mm-dd'),1,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-29', 'yyyy-mm-dd'),1,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-29', 'yyyy-mm-dd'),1,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">인사부 사원 여러분들은 8시 출근이 아닌 8시 30분에  출근해 주십시오</span></h2>', to_date('2020-07-29', 'yyyy-mm-dd'),1,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)출근시간 변경 공지 입니다.', '<h2><span style="color:#16a085;">인사부 대리 여러분들은 8시 출근이 아닌 8시 30분에 출근해 주십시오</span></h2>', to_date('2020-07-27', 'yyyy-mm-dd'),1,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">인사부 팀장 여러분들은 8시 출근이 아닌 8시 30분에 출근해 주십시오</span></h2>', to_date('2020-07-26', 'yyyy-mm-dd'),1,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">인사부 부장 여러분들은 8시 출근이 아닌 8시 30분에 출근해 주십시오</span></h2>', to_date('2020-07-25', 'yyyy-mm-dd'),1,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">인사부 과장 여러분들은 8시 출근이 아닌 8시 30분에 출근해 주십시오</span></h2>', to_date('2020-07-24', 'yyyy-mm-dd'),1,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-18', 'yyyy-mm-dd'),2,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-18', 'yyyy-mm-dd'),2,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-18', 'yyyy-mm-dd'),2,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-18', 'yyyy-mm-dd'),2,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-06-18', 'yyyy-mm-dd'),2,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">총무부 사원 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-07-13', 'yyyy-mm-dd'),2,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">총무부 대리 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-07-13', 'yyyy-mm-dd'),2,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">총무부 팀장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-07-13', 'yyyy-mm-dd'),2,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">총무부 부장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-07-13', 'yyyy-mm-dd'),2,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">총무부 과장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-07-13', 'yyyy-mm-dd'),2,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-18', 'yyyy-mm-dd'),3,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-18', 'yyyy-mm-dd'),3,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-18', 'yyyy-mm-dd'),3,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-18', 'yyyy-mm-dd'),3,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-18', 'yyyy-mm-dd'),3,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">경영지원부 사원 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2019-07-12', 'yyyy-mm-dd'),3,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">경영지원부 대리 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2019-07-12', 'yyyy-mm-dd'),3,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">경영지원부 팀장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2019-07-12', 'yyyy-mm-dd'),3,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">경영지원부 부장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2019-07-12', 'yyyy-mm-dd'),3,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">경영지원부 과장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2019-07-12', 'yyyy-mm-dd'),3,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)구조조정 관련 공지 입니다.', '<h2><span style="color:#ffffff;"><span style="background-color:#9b59b6;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)출근시간 변경 공지 입니다.', '<h3><span style="color:#2980b9;"><strong>영업부 사원 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오.</strong></span></h3><p>출퇴근 시간을 지켜 주시기 바랍니다.</p>', to_date('2020-04-12', 'yyyy-mm-dd'),4,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 대리 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 팀장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 부장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 과장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),5,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),5,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),5,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),5,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),5,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부  사원 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),5,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부 대리 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),5,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부 팀장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),5,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부 부장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),5,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부 과장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),5,5);

INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '장마로 인한 출퇴근 시간변동 공지 입니다.', '<h3><span style="color:#2980b9;"><strong>전직원 여러분들은 9시20분 까지 출근해주시기 바랍니다.</strong></span></h3><p>조심히 출근하실 수 있도록 주의해 주십시오</p>', to_date('2020-08-03', 'yyyy-mm-dd'),1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 공지', '<p>고생 많았습니다.</p>', to_date('2020-08-01', 'yyyy-mm-dd'),4,1);


/* 사원 더미 */
INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '사사원', to_date('1990-11-07', 'YYYY-MM-DD'), 'test@gmail.com', 'test', '123', 50000000, 1, 1);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '나사직', to_date('1993-02-28', 'YYYY-MM-DD'), 'nasa@gmail.com', 'nasa', '123', 50000000, 1, 2);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '사지원', to_date('1995-01-25', 'YYYY-MM-DD'), 'sup@gmail.com', 'sup', '123', 50000000, 1, 3);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '영업왕입니다', to_date('1894-11-14', 'YYYY-MM-DD'), 'king@gmail.com', 'king', '123', 50000000, 1, 4);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, EMP_ADDR, EMP_PHONENUM , emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '공돌이', to_date('1898-10-04', 'YYYY-MM-DD'), 'gong@gmail.com', 'gong', '123', '123456 서울특별시 강남구 강남로 한강변 초대형 아파트 제일 윗층과 인천광역시 부평구 신생로 새로생긴 아파트 102동 402호에 살고있는 공돌이 입니다.', 01012345678,50000000, 1, 5);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '대대리', to_date('1980-01-07', 'YYYY-MM-DD'), 'bald@gmail.com', 'bald', '123', 60000000, 2, 1);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '나팀장', to_date('1983-12-08', 'YYYY-MM-DD'), 'team@gmail.com', 'team', '123', 70000000, 3, 2);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '사부장', to_date('1978-01-25', 'YYYY-MM-DD'), 'sabu@gmail.com', 'sabu', '123', 80000000, 4, 3);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '과자앙', to_date('1874-10-24', 'YYYY-MM-DD'), 'jjang@gmail.com', 'jjang', '123', 90000000, 5, 4);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '사장임', to_date('1868-06-04', 'YYYY-MM-DD'), 'sajang@gmail.com', 'sajang', '123', 100000000, 6, 5);
;

INSERT INTO employees (emp_uid, emp_name, emp_birthdate, emp_email, emp_id, emp_pw, emp_salary, p_uid, dep_uid)
VALUES (SEQ_employees_emp_uid.nextval, '인사관리', to_date('2020-06-04', 'YYYY-MM-DD'), 'dnd194@gmail.com', 'insa@insa.com', '123', 100000000, 7, 1);
;

/* 휴가 더미 */
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-01', 'YYYY-MM-DD'), to_date('2020-07-03', 'YYYY-MM-DD'), 1)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-07', 'YYYY-MM-DD'), to_date('2020-07-10', 'YYYY-MM-DD'), 2)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-13', 'YYYY-MM-DD'), to_date('2020-07-13', 'YYYY-MM-DD'), 3)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-08-17', 'YYYY-MM-DD'), to_date('2020-08-19', 'YYYY-MM-DD'), 4)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-16', 'YYYY-MM-DD'), to_date('2020-07-17', 'YYYY-MM-DD'), 5)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-07', 'YYYY-MM-DD'), to_date('2020-07-09', 'YYYY-MM-DD'), 6)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-20', 'YYYY-MM-DD'), to_date('2020-07-23', 'YYYY-MM-DD'), 7)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-20', 'YYYY-MM-DD'), to_date('2020-07-24', 'YYYY-MM-DD'), 8)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-28', 'YYYY-MM-DD'), to_date('2020-07-31', 'YYYY-MM-DD'), 9)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-27', 'YYYY-MM-DD'), to_date('2020-07-28', 'YYYY-MM-DD'), 10)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-23', 'YYYY-MM-DD'), to_date('2020-07-24', 'YYYY-MM-DD'), 10)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-17', 'YYYY-MM-DD'), to_date('2020-07-17', 'YYYY-MM-DD'), 4)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-20', 'YYYY-MM-DD'), to_date('2020-07-20', 'YYYY-MM-DD'), 4)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-08-05', 'YYYY-MM-DD'), to_date('2020-08-07', 'YYYY-MM-DD'), 5)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-08-05', 'YYYY-MM-DD'), to_date('2020-08-07', 'YYYY-MM-DD'), 6)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-08-05', 'YYYY-MM-DD'), to_date('2020-08-05', 'YYYY-MM-DD'), 7)
;



-- 문서 더미
INSERT INTO doc_table VALUES (seq_uid.nextval, '휴가신청서', '휴가신청서 양식입니다', 'requestVacation.hwp');
INSERT INTO doc_table VALUES (seq_uid.nextval, '사유서', '사유서 양식입니다', 'Explaination.hwp');
INSERT INTO doc_table VALUES (seq_uid.nextval, '퇴직증명서', '퇴직증명서 양식입니다', 'retirementVerify.hwp');
INSERT INTO doc_table VALUES (seq_uid.nextval, '회의록', '회의록 양식입니다', 'meetingrecord.docx');
INSERT INTO doc_table VALUES (seq_uid.nextval, '일간스케쥴', '일간스케쥴 양식입니다', 'WorkSchedule.hwp');
INSERT INTO doc_table VALUES (seq_uid.nextval, '근무확인서', '근무확인서 양식입니다', 'WorkCertification.xls');

-- 회사 출결 Dummy --
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 07:23:59', '2020-07-01 18:50:20', 1);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:12:59', '2020-07-01 18:30:20', 2);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 09:15:59', '2020-07-01 18:20:20', 3);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 07:50:59', '2020-07-01 18:00:20', 5);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:30:59', '2020-07-01 19:10:20', 6);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:10:59', '2020-07-01 19:20:20', 7);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:40:59', '2020-07-01 19:30:20', 8);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 09:34:59', '2020-07-01 19:40:20', 9);

INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 08:23:59', '2020-07-02 18:50:20', 1);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 09:23:59', '2020-07-02 18:50:20', 2);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 10:23:59', '2020-07-02 18:50:20', 3);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 5);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 6);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 7);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 8);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 9);

INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 1);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 2);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 3);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 5);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 6);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 7);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 8);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 9);

INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-04 10:23:59', '2020-07-03 17:50:20', 9);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-06 09:23:59', '2020-07-03 20:50:20', 9);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-12 08:23:59', '2020-07-03 20:50:20', 9);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 9);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 9);

-- 출결더미 4번의 7월
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-06 08:23:59', '2020-07-06 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-07 09:23:59', '2020-07-07 21:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-08 08:23:59', '2020-07-08 20:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-09 08:23:59', '2020-07-09 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-10 08:23:59', '2020-07-10 19:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-13 08:23:59', '2020-07-13 15:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-14 10:23:59', '2020-07-14 19:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-15 08:23:59', '2020-07-15 19:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-16 08:23:59', '2020-07-16 18:50:20', 4);
/*INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-17 08:23:59', '2020-07-17 18:50:20', 4);
 * 
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-20 08:23:59', '2020-07-20 18:50:20', 4);*/
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-21 08:23:59', '2020-07-21 20:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-22 08:23:59', '2020-07-22 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-23 09:23:59', '2020-07-23 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-24 08:23:59', '2020-07-24 20:50:20', 4);

INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-27 08:23:59', '2020-07-27 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-28 08:23:59', '2020-07-28 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-29 09:23:59', '2020-07-29 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-30 08:23:59', '2020-07-30 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-31 08:23:59', '2020-07-31 18:50:20', 4);
INSERT INTO OFFICE_HOUR (w_uid, W_START , W_END , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-03 08:20:30', '2020-08-03 18:20:26', 4);
INSERT INTO OFFICE_HOUR (w_uid, W_START , W_END , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-04 08:30:30', '2020-08-04 18:20:26', 4);

INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-05 08:45:30', 1);
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-05 08:45:30', 2);
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-05 09:45:30', 3);
/*INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-05 10:45:30',5);
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-05 08:20:30', 6);
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-05 08:50:30', 7);*/
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-05 08:30:30', 8);
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID ) VALUES (SEQ_office_hour_w_uid.nextval, '2020-08-05 07:45:30', 9);


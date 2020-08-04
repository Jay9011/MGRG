-- xml mapper 에서가져온 쿼리문 --
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
FROM (SELECT * FROM EMPLOYEES e WHERE e.EMP_UID NOT IN (10, 11))e LEFT OUTER JOIN OFFICE_HOUR oh ON e.emp_uid = oh.EMP_UID AND 
to_char(oh.W_START, 'yyyy-mm-dd') =  TO_CHAR(sysdate, 'yyyy-mm-dd')
ORDER BY e.EMP_UID) h) category ON e.EMP_UID = category.EMP_UID
			WHERE e.DEP_UID = d.dep_uid AND e.P_UID = p.P_UID AND e.P_UID NOT IN (6, 7)
ORDER BY e.EMP_NAME;


SELECT * FROM EMPLOYEES e ;
SELECT * FROM OFFICE_HOUR oh ;

-- 나 팀장 한달 출근 근황 --
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES 
(SEQ_office_hour_w_uid.nextval, '2020-07-31 09:55:52',  7) ;

-- 나 팀장 한달 출근 근황 --
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES 
(SEQ_office_hour_w_uid.nextval, '2020-07-31 09:23:52',  5) ;

---------------------------------------------------------------

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

-- chart js에 쓸 쿼리문 --
/* 
 * "이번달" 직원 "출근/지각/결근/조퇴" 를 다 합하여 
 *  컬럼으로 출근 = # 지각 = # 결근 = # 이런식으로 뽑아야한다
 */

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

-------------------------------------------------------------------------------------------------------------		
-- attendance VIEW를 활용해서 직원 한달 출결 횟수 뽑기--------------------------------------------------------------------
SELECT * FROM attendance WHERE "uid" = 4;
SELECT count(*) FROM attendance WHERE "uid" = 4 AND TO_CHAR("start", 'mm') = TO_CHAR(SYSDATE, 'mm') ;

SELECT COUNT(CASE 
			 WHEN "status" = '미출근' THEN '미출근' END ) AS absent, 
	   COUNT(CASE 
			 WHEN "status" = '퇴근' THEN '퇴근' END ) AS off, 
	   COUNT(CASE 
			 WHEN "status" = '조퇴' THEN '조퇴' END ) AS earlyOff, 
	   COUNT(CASE 
			 WHEN "status" = '지각' THEN '지각' END ) AS late
FROM attendance WHERE "uid" = 3 AND TO_CHAR("start", 'mm') = TO_CHAR(to_date('2020-08-30'), 'mm');
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
SELECT * FROM attendance WHERE "uid" = 3;
SELECT * FROM OFFICE_HOUR oh WHERE EMP_UID = 7;
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID )
VALUES (SEQ_OFFICE_HOUR_W_UID.NEXTVAL, '2020-08-03 08:56:00' , '2020-08-03 18:20:23', 3);
INSERT INTO HOLIDAY (H_UID , H_START , H_END , EMP_UID )
VALUES (SEQ_HOLIDAY_H_UID.nextval, '2020-07-29', '2020-08-01', 7);

SELECT att.*,  FROM attendance att, ;
INSERT INTO OFFICE_HOUR ();
-- 8월까지 휴가인 직원 INSERT
INSERT INTO HOLIDAY (H_UID , H_START , H_END , EMP_UID )
VALUES
(
	SEQ_HOLIDAY_H_UID.nextval, to_date('2020-08-03', 'yyyy-mm-dd'), to_date('2020-08-03', 'yyyy-mm-dd'), 1
)


SELECT * FROM HOLIDAY h ;
SELECT * FROM POSITIONRANK p2 ;
-- 휴가테이블이랑 직원 테이블 조인해서 뽑기 --
SELECT e.EMP_UID , h.H_UID , e.EMP_NAME "name", h.H_START "startDay", h.H_END "endDay", (TO_NUMBER(TO_CHAR(h.H_END , 'dd') ) - TO_NUMBER(TO_CHAR(h.H_START , 'dd') ) + 1) AS days 
FROM EMPLOYEES e , HOLIDAY h 
WHERE e.EMP_UID = h.EMP_UID AND e.EMP_UID = 1 AND (TO_DATE('2020-07-15', 'yyyy-mm-dd') BETWEEN h.H_START AND h.H_END)
ORDER BY h.H_START asc;

--  --
SELECT e.EMP_UID , h.H_UID , e.EMP_NAME "name", h.H_START "startDay", h.H_END "endDay", p.P_HOLIDAY - (TO_NUMBER(TO_CHAR(h.H_END , 'dd') ) - TO_NUMBER(TO_CHAR(h.H_START , 'dd') ) + 1) AS days  
FROM EMPLOYEES e , HOLIDAY h , POSITIONRANK p
WHERE e.P_UID = p.P_UID AND e.EMP_UID = h.EMP_UID AND e.EMP_UID = 1 AND ((h.H_START BETWEEN TO_DATE('2020-08', 'yyyy-mm') AND TO_DATE('2020-08-15', 'yyyy-mm-dd')) OR (h.H_END BETWEEN TO_DATE('2020-08', 'yyyy-mm') AND TO_DATE('2020-08-15', 'yyyy-mm-dd') ) )
ORDER BY h.H_START asc;

SELECT * FROM HOLIDAY h WHERE EMP_UID = 1;

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-- 만약 휴가가 다음달까지 연장 되어있을때 이번달 말일 - 이번달 휴가 시작일 + 1 해주기
SELECT NVL( sum(
	CASE 
		WHEN TRUNC(LAST_DAY(SYSDATE), 'dd') BETWEEN h.H_START AND h.H_END THEN TRUNC(LAST_DAY(SYSDATE), 'dd') - h.H_START + 1
		WHEN TRUNC(SYSDATE ,'mm') BETWEEN h.H_START AND h.H_END THEN h.H_END - TRUNC(sysdate, 'mm')
		ELSE h.H_END - h.H_START + 1
		END ), 0) AS holidayCnt 
FROM HOLIDAY h 
WHERE EMP_UID = 7 AND TO_CHAR(H_START , 'mm') = TO_CHAR(SYSDATE , 'mm')
;
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW holi_count AS 
SELECT h.EMP_UID ,
	CASE 
		-- 이번달 말이 휴가일에 포함이 되어 있다면 --
		WHEN TRUNC(LAST_DAY(SYSDATE), 'dd') BETWEEN h.H_START AND h.H_END THEN TRUNC(LAST_DAY(SYSDATE), 'dd') - h.H_START + 1
		WHEN TRUNC(SYSDATE ,'mm') BETWEEN h.H_START AND h.H_END THEN h.H_END - TRUNC(sysdate, 'mm')
		ELSE h.H_END - h.H_START + 1
		END AS holidayCnt 
FROM HOLIDAY h ;
SELECT count(*) FROM holi_count WHERE emp_uid = 7 ;
SELECT * FROM holi_count;
SELECT * FROM HOLIDAY h2 ;
-- DROP VIEW holi_count;

SELECT * FROM holi_count hc , HOLIDAY h 
WHERE hc.EMP_UID = 1 AND TO_CHAR(h.H_START , 'mm') = TO_CHAR(SYSDATE , 'mm') ;

INSERT INTO HOLIDAY (H_UID , H_START , H_END , EMP_UID )
VALUES (SEQ_HOLIDAY_H_UID.nextval, '2020-08-23', '2020-08-25', 1);

SELECT * FROM attendance WHERE "uid" = 4;
SELECT count(*) FROM attendance WHERE "uid" = 4 AND TO_CHAR("start", 'mm') = TO_CHAR(SYSDATE, 'mm') ;

SELECT trunc(last_day(SYSDATE), 'dd')
FROM DUAL 
;
-- 저번달 휴가 시작일 ~ 이번달 휴가 끝일
INSERT INTO HOLIDAY (H_UID , H_START , H_END , EMP_UID )
VALUES (SEQ_HOLIDAY_H_UID.nextval, '2020-06-28', '2020-07-03', 1);

SELECT * FROM HOLIDAY h ;
SELECT * FROM HOLI h ;

SELECT to_number(to_char(sysdate,'DD')) FROM dual;
SELECT trunc(sysdate) - (to_number(to_char(sysdate,'DD')) - 1) FROM dual;
SELECT add_months(trunc(sysdate) - (to_number(to_char(sysdate,'DD')) - 1), 1) -1 FROM dual;

SELECT * FROM HOLIDAY h ;

-----------------------------------
-- 해당 uid값을 가진 직원이 현재 날짜까지 뽑기 --
SELECT count(*)
FROM currStatus
;

SELECT * FROM currStatus;
SELECT * FROM attendance;

CREATE OR REPLACE VIEW currStatus AS 
SELECT e.EMP_UID "e_uid", e.EMP_NAME name, category.W_START "start", d.DEP_NAME posRank, p.P_NAME dept, category.W_END "end", category.stat "status", category.w_uid 
FROM DEPARTMENT d , POSITIONRANK p , EMPLOYEES e LEFT OUTER JOIN 
	(SELECT  
		h.*,
		CASE
			WHEN h.endTime IS NOT NULL THEN '퇴근'
			WHEN h.endTime < 1800 THEN '조퇴'
			WHEN h.startTime IS NULL THEN '미출근'
			WHEN h.startTime <= 900 THEN '출근'
			WHEN h.startTime <= 930 THEN '지각'
			ELSE '결근'
			END AS stat
	FROM (SELECT oh.*, TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
				 to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
		  FROM OFFICE_HOUR oh 
		  WHERE to_char(oh.W_START, 'yyyy-mm-dd') = TO_CHAR(SYSDATE,'yyyy-mm-dd')) h) category ON e.EMP_UID = category.EMP_UID
		  WHERE e.DEP_UID = d.dep_uid AND e.P_UID = p.P_UID AND e.P_UID NOT IN (6, 7)
ORDER BY e.EMP_NAME;

SELECT e.EMP_UID "e_uid", e.EMP_NAME name, category.W_START "start", category.W_END "end", category.stat "status", d.DEP_NAME posRank, p.P_NAME dept, category.w_uid 
FROM DEPARTMENT d , POSITIONRANK p , EMPLOYEES e LEFT OUTER JOIN 
	(SELECT  
		h.*,
		CASE
			WHEN h.endTime IS NOT NULL THEN '퇴근'
			WHEN h.endTime < 1800 THEN '조퇴'
			WHEN h.startTime IS NULL THEN '미출근'
			WHEN h.startTime <= 900 THEN '출근'
			WHEN h.startTime <= 930 AND h.endTime IS NOT NULL THEN '지각'
			ELSE '결근'
			END AS stat
	FROM (SELECT oh.*, TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
				 to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
		  FROM OFFICE_HOUR oh 
		  ) h) category ON e.EMP_UID = category.EMP_UID
		  WHERE e.DEP_UID = d.dep_uid AND e.P_UID = p.P_UID AND e.P_UID NOT IN (6, 7)
ORDER BY e.EMP_NAME;

SELECT * FROM OFFICE_HOUR oh ;

SELECT 
FROM EMPLOYEES e , OFFICE_HOUR oh , LEFT OUTER JOIN 
	(SELECT  
		h.*,
		CASE
			WHEN h.endTime IS NOT NULL THEN '퇴근'
			WHEN h.endTime < 1800 THEN '조퇴'
			WHEN h.startTime IS NULL THEN '미출근'
			WHEN h.startTime <= 900 THEN '출근'
			WHEN h.startTime <= 930 THEN '지각'
			ELSE '결근'
			END AS stat
	FROM (SELECT oh.*, TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
				 to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
		  FROM OFFICE_HOUR oh 
		  WHERE to_char(oh.W_START, 'yyyy-mm-dd') = TO_CHAR(SYSDATE,'yyyy-mm-dd')) h);
		 
		 
SELECT * FROM EMPLOYEES e ;
SELECT * FROM POSITIONRANK p ;
		 
		 
-- 회사 출결 Dummy --
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 07:23:59', '2020-07-01 18:50:20', 1);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:12:59', '2020-07-01 18:30:20', 2);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 09:15:59', '2020-07-01 18:20:20', 3);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:20:59', '2020-07-01 18:10:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 07:50:59', '2020-07-01 18:00:20', 5);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:30:59', '2020-07-01 19:10:20', 6);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:10:59', '2020-07-01 19:20:20', 7);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 08:40:59', '2020-07-01 19:30:20', 8);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-01 09:34:59', '2020-07-01 19:40:20', 9);

INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 08:23:59', '2020-07-02 18:50:20', 1);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 09:23:59', '2020-07-02 18:50:20', 2);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 10:23:59', '2020-07-02 18:50:20', 3);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 5);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 6);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 7);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 8);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-02 07:23:59', '2020-07-02 18:50:20', 9);

INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 1);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 2);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 3);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-03 07:23:59', '2020-07-03 18:50:20', 4);
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

-- uid 가 4 인 직원 출결 dummy variables
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-06 08:23:59', '2020-07-06 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-07 08:23:59', '2020-07-07 21:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-08 08:23:59', '2020-07-08 20:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-09 08:23:59', '2020-07-09 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-10 08:23:59', '2020-07-10 19:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-13 08:23:59', '2020-07-13 15:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-14 08:23:59', '2020-07-14 19:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-15 08:23:59', '2020-07-15 19:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-16 08:23:59', '2020-07-16 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-17 08:23:59', '2020-07-17 18:50:20', 4);

INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-20 08:23:59', '2020-07-20 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-21 08:23:59', '2020-07-21 20:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-22 08:23:59', '2020-07-22 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-23 08:23:59', '2020-07-23 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-24 08:23:59', '2020-07-24 20:50:20', 4);

INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-27 08:23:59', '2020-07-27 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-28 08:23:59', '2020-07-28 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-29 08:23:59', '2020-07-29 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-30 08:23:59', '2020-07-30 18:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-31 08:23:59', '2020-07-31 18:50:20', 4);


----------- dummy variables (2020-07-29) 출근 시간 ------------
INSERT INTO OFFICE_HOUR (w_uid, W_START , W_END , EMP_UID )
VALUES
(SEQ_office_hour_w_uid.nextval, '2020-07-29 07:55:32', 5);

INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES
(SEQ_office_hour_w_uid.nextval, '2020-07-29 07:55:32', 9);

INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES
(SEQ_office_hour_w_uid.nextval, '2020-07-29 08:55:32', 2);

INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES
(SEQ_office_hour_w_uid.nextval, '2020-07-29 09:55:32', 6);

INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES
(SEQ_office_hour_w_uid.nextval, '2020-07-29 07:20:32', 10);

INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES
(SEQ_office_hour_w_uid.nextval, '2020-07-29 07:50:32', 3);

INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES
(SEQ_office_hour_w_uid.nextval, '2020-07-29 08:45:30', 4);

-- 다른 날짜 --
INSERT INTO OFFICE_HOUR (w_uid, W_START , EMP_UID )
VALUES
(SEQ_office_hour_w_uid.nextval, '2020-08-03 08:45:30', 4);














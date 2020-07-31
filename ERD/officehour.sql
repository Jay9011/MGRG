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
	FROM (SELECT e.EMP_UID , oh.W_UID , oh.W_START , oh.W_END , TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
				 to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
	FROM EMPLOYEES e RIGHT OUTER JOIN OFFICE_HOUR oh ON e.emp_uid = oh.EMP_UID 
	WHERE to_char(oh.W_START, 'yyyy-mm-dd') =  TO_CHAR(sysdate, 'yyyy-mm-dd')) h) category ON e.EMP_UID = category.EMP_UID
			WHERE e.DEP_UID = d.dep_uid AND e.P_UID = p.P_UID AND e.P_UID NOT IN (6, 7)
ORDER BY e.EMP_NAME;
		
SELECT e.emp_uid , oh.W_START , oh.W_END , TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
				 to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
FROM (SELECT * FROM EMPLOYEES e WHERE e.EMP_UID NOT IN (10, 11))e LEFT OUTER JOIN OFFICE_HOUR oh ON e.emp_uid = oh.EMP_UID;
WHERE to_char(oh.W_START, 'yyyy-mm-dd') =  TO_CHAR(sysdate, 'yyyy-mm-dd');

SELECT e.emp_uid , oh.W_START , oh.W_END , TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
				 to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
FROM (SELECT * FROM EMPLOYEES e WHERE e.EMP_UID NOT IN (10, 11))e LEFT OUTER JOIN OFFICE_HOUR oh ON e.emp_uid = oh.EMP_UID AND 
to_char(oh.W_START, 'yyyy-mm-dd') =  TO_CHAR(sysdate, 'yyyy-mm-dd')
ORDER BY e.EMP_UID;
			
SELECT emp_uid FROM EMPLOYEES e WHERE e.EMP_UID NOT IN (10, 11);

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

-- chart js에 쓸 쿼리문 --
/* 
 * "이번달" 직원 "출근/지각/결근/조퇴" 를 다 합하여 
 *  컬럼으로 출근 = # 지각 = # 결근 = # 이런식으로 뽑아야한다
 */
SELECT * FROM OFFICE_HOUR;

SELECT COUNT(CASE 
			 WHEN STAT = '출근' THEN '출근' END ) AS intime, 
	   COUNT(CASE 
			 WHEN STAT = '퇴근' THEN '퇴근' END ) AS off, 
	   COUNT(CASE 
			 WHEN STAT = '조퇴' THEN '조퇴' END ) AS earlyOff, 
	   COUNT(CASE 
			 WHEN STAT = '지각' THEN '지각' END ) AS late
FROM (SELECT 
		h.*,
		CASE
			WHEN h.endTime < 1800 THEN '조퇴'
			WHEN h.endTime > 1800 THEN '퇴근'
			WHEN h.startTime IS NULL THEN '미출근'
			WHEN h.endtime IS NULL AND h.startTime <= 900 THEN '출근'
			WHEN h.startTime <= 930 THEN '지각'
			ELSE '결근'
			END AS stat
	FROM (SELECT oh.*, TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
				 to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
		  FROM OFFICE_HOUR oh 
		  WHERE (oh.W_START BETWEEN TRUNC(SYSDATE, 'mm') AND TRUNC(SYSDATE, 'dd')) AND oh.EMP_UID = 4) h)
		  ;
		  
		 
SELECT * FROM OFFICE_HOUR oh WHERE EMP_UID = 4;
INSERT INTO OFFICE_HOUR (W_UID , W_START , EMP_UID )
VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-31 08:55:20', 4);
DELETE FROM OFFICE_HOUR oh WHERE EMP_UID = 4 AND W_START = '2020-07-31 08:55:20';
		 
-- 이번 달 주말 제외한 모든 날짜의 출근 현황 뽑기
SELECT *
FROM (SELECT mon.*
      FROM (SELECT TRUNC(SYSDATE ,'mm') + LEVEL - 1 AS IN_DATE
         FROM DUAL CONNECT BY LEVEL <= ROUND(SYSDATE - TRUNC(SYSDATE,'mm'))) mon
      WHERE TO_CHAR(mon.IN_DATE, 'd') NOT IN (1, 7)) work_day
LEFT OUTER JOIN (SELECT * FROM OFFICE_HOUR WHERE EMP_UID = 4) oh 
ON oh.W_START BETWEEN work_day.in_date AND work_day.in_date + 1
;

-- 휴일 뺀 이번 월 모든 날짜 뽑기
SELECT mon.*
FROM (SELECT TRUNC(SYSDATE ,'mm') + LEVEL - 1 AS IN_DATE
   FROM DUAL CONNECT BY LEVEL <= ROUND(SYSDATE - TRUNC(SYSDATE,'mm'))) mon
WHERE TO_CHAR(mon.IN_DATE, 'd') NOT IN (1, 7)
;

SELECT TRUNC(SYSDATE ,'mm') + LEVEL - 1 FROM dual;

SELECT ROUND(SYSDATE - TRUNC(SYSDATE,'mm')) FROM dual;

-- 8월까지 휴가인 직원 INSERT
INSERT INTO HOLIDAY (H_UID , H_START , H_END , EMP_UID )
VALUES
(
	SEQ_HOLIDAY_H_UID.nextval, to_date('2020-07-28', 'yyyy-mm-dd'), to_date('2020-08-03', 'yyyy-mm-dd'), 1
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

-- 만약 휴가가 다음달까지 연장 되어있을때 이번달 말일 - 이번달 휴가 시작일 + 1 해주기
SELECT 
	CASE 
		-- 이번달 말이 휴가일에 포함이 되어 있다면 --
		WHEN TRUNC(LAST_DAY(SYSDATE), 'dd') BETWEEN h.H_START AND h.H_END THEN TRUNC(LAST_DAY(SYSDATE), 'dd') - h.H_START + 1
		WHEN TRUNC(SYSDATE ,'mm') BETWEEN h.H_START AND h.H_END THEN h.H_END - TRUNC(sysdate, 'mm')
		ELSE h.H_END - h.H_START + 1
		END AS holidayCnt 
FROM HOLIDAY h 
WHERE EMP_UID = 1
;


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
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-06 08:23:59', '2020-07-06 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-07 08:23:59', '2020-07-07 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-08 08:23:59', '2020-07-08 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-09 08:23:59', '2020-07-09 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-10 08:23:59', '2020-07-10 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-13 08:23:59', '2020-07-13 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-14 08:23:59', '2020-07-14 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-15 08:23:59', '2020-07-15 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-16 08:23:59', '2020-07-16 17:50:20', 4);
INSERT INTO OFFICE_HOUR (W_UID , W_START , W_END , EMP_UID ) VALUES (SEQ_OFFICE_HOUR_W_UID.nextval, '2020-07-17 08:23:59', '2020-07-17 17:50:20', 4);


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
(SEQ_office_hour_w_uid.nextval, '2020-07-20 08:45:30', 4);














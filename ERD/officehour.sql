-- xml mapper 에서가져온 쿼리문 --
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
		  WHERE to_char(oh.W_START, 'yyyy-mm-dd') = TO_CHAR(SYSDATE,'yyyy-mm-dd') h) category ON e.EMP_UID = category.EMP_UID
		  WHERE e.DEP_UID = d.dep_uid AND e.P_UID = p.P_UID AND e.P_UID NOT IN (6, 7)
ORDER BY e.EMP_NAME;
			
-- 나 팀장 한달 출근 근황 --
INSERT INTO OFFICE_HOUR (w_uid, W_START , W_END, EMP_UID )
VALUES 
(SEQ_office_hour_w_uid.nextval, '2020-07-08 07:55:52', '2020-07-08 18:40:52',  7) ;


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
		  WHERE (oh.W_START BETWEEN TRUNC(SYSDATE, 'mm') AND TRUNC(SYSDATE, 'dd')) AND oh.EMP_UID = 7) h)
		  ;
		  
-- 이번 달 주말 제외한 모든 날짜의 출근 현황 뽑기
SELECT *
FROM (SELECT mon.*
      FROM (SELECT TRUNC(SYSDATE ,'mm') + LEVEL - 1 AS IN_DATE
         FROM DUAL CONNECT BY LEVEL <= SYSDATE - TRUNC(SYSDATE,'mm')) mon
      WHERE TO_CHAR(mon.IN_DATE, 'd') NOT IN (1, 7)) work_day
   LEFT OUTER JOIN (SELECT * FROM OFFICE_HOUR WHERE EMP_UID = 4) oh 
   ON oh.W_START BETWEEN work_day.in_date AND work_day.in_date + 1
   
;

-- 휴일 뺀 이번 월 모든 날짜 뽑기
SELECT mon.*
FROM (SELECT TRUNC(SYSDATE ,'mm') + LEVEL - 1 AS IN_DATE
   FROM DUAL CONNECT BY LEVEL <= SYSDATE - TRUNC(SYSDATE,'mm')) mon
WHERE TO_CHAR(mon.IN_DATE, 'd') NOT IN (1, 7)
;

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

-- 해당 직원의 휴가 사용일 --
SELECT * FROM HOLI h ;
SELECT * FROM HOLIDAY h ;

SELECT * FROM EMP e ;

SELECT e.NAME , e."position" , e.DEPARTMENT , h.H_START , h.H_END , e."useHoliday" , e."total" , e."leftHoliday" 
FROM EMP e , HOLIDAY h
WHERE e."uid" = h.EMP_UID AND e."uid" = 1
;

SELECT LAST_DAY(to_date(SYSDATE, 'yy-mm-dd') ), ADD_MONTHS(to_date(sysdate), + 1) FROM dual; 

-- 만약 휴가가 다음달까지 연장 되어있을때 이번달 말일 - 이번달 휴가 시작일 + 1 해주기
SELECT 
	CASE 
		WHEN last_day(to_date(SYSDATE, 'yy-mm-dd') ) BETWEEN h.H_START AND h.H_END THEN last_day(to_date(SYSDATE, 'yy-mm-dd') ) - h.H_START + 1
		ELSE h.H_END - h.H_START + 1
		END AS holidayCnt 
FROM HOLIDAY h 
WHERE EMP_UID = 1;

SELECT * FROM HOLIDAY h ;
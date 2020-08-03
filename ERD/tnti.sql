SELECT h_uid "uid", h_start startTime, h_end endTime, emp_uid emp_uid FROM HOLIDAY WHERE EMP_UID = 1;
SELECT h.h_uid "uid", h.h_start startTime, h.h_end endTime, e."uid" empuid, e.NAME name,e.P_UID puid,e.DEP_UID depuid, e."position" "position", e.DEPARTMENT  departmemt, e."leftHoliday" leftHoliday FROM HOLIDAY h JOIN EMP e ON h.EMP_UID = e."uid" ;
SELECT  * FROM emp;

SELECT e.EMP_UID "uid", category.W_START "startTime", category.stat "status"
FROM EMPLOYEES e JOIN DEPARTMENT d ON e.DEP_UID = d.dep_uid JOIN POSITIONRANK p ON e.P_UID = p.P_UID
  JOIN  (SELECT  
      h.*,
      CASE
         WHEN h.endTime IS NOT NULL THEN '퇴근'
         WHEN h.startTime <= 900 THEN '출근'
         WHEN h.startTime <= 930 THEN '지각'
         ELSE '결근'
         END AS stat
   FROM (SELECT oh.*, TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
             to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
         FROM OFFICE_HOUR oh ) h) category ON e.EMP_UID = category.EMP_UID
WHERE e.EMP_UID = 1;

--사원의 남은 휴가일수
SELECT "useHoliday" , EMP_UID empuid FROM holi;

-- 휴가를 이번달 사용했는지 
SELECT * FROM HOLIDAY ;
SELECT h.H_UID "uid", e."uid" "euid",e.NAME name, e."position" "position",e.PHONENUM PHONENUM,e.DEPARTMENT DEPARTMENT, h.H_START startTime, h.H_END endTime, e."total" ,e."leftHoliday" ,e."useHoliday" FROM HOLIDAY h JOIN EMP e ON h.EMP_UID = e."uid" ;
SELECT * FROM HOLIDAY h JOIN EMP e ON h.EMP_UID = e."uid" ;


SELECT TO_CHAR(H_START, 'yyyy-mm') AS "START", TO_CHAR(H_END , 'yyyy-mm') AS "END" FROM HOLIDAY WHERE EMP_UID =2;
	
SELECT A.DT
  FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYY-MM-DD') DT,
                   TO_CHAR (SDT + LEVEL - 1, 'D') D
              FROM (SELECT TO_DATE ((TO_CHAR(SYSDATE , 'YYYY')||'01-01'),'YYYY-MM-DD') SDT,
                           TO_DATE ((TO_CHAR(SYSDATE, 'YYYY')||'12-31'),'YYYY-MM-DD')EDT
                      FROM DUAL)
        CONNECT BY LEVEL <= EDT - SDT + 1) A,
       (
        (SELECT TO_DATE((TO_CHAR( '20200505', 'YYYY-MM-DD') AS DT, '어린이날' CMT FROM DUAL 
       ) B
 WHERE TO_DATE(A.DT, 'YYYY-MM-DD') = B.DT(+) 
    AND A.D NOT IN ('1', '7')  -- 토/일요일 제외
    AND B.DT IS NULL;
   

-- 이번 달 주말 제외한 모든 날짜의 출근 현황 뽑기
SELECT *
FROM (SELECT mon.*
		FROM (SELECT TRUNC(SYSDATE ,'mm') + LEVEL - 1 AS IN_DATE
			FROM DUAL CONNECT BY LEVEL <= SYSDATE - TRUNC(SYSDATE,'mm')) mon
		WHERE TO_CHAR(mon.IN_DATE, 'd') NOT IN (1, 7)) work_day
	LEFT OUTER JOIN (SELECT * FROM OFFICE_HOUR WHERE EMP_UID = 2) oh 
	ON oh.W_START BETWEEN work_day.in_date AND work_day.in_date + 1
;


SELECT A.DT
  FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYY-MM-DD') DT,
                   TO_CHAR (SDT + LEVEL - 1, 'D') D
              FROM (SELECT TO_DATE ('2020-07-31' , 'YYYY-MM-DD') SDT,
                           TO_DATE ('2020-08-03', 'YYYY-MM-DD') EDT
                      FROM DUAL)
        CONNECT BY LEVEL <= EDT - SDT + 1) A
   WHERE A.D NOT IN ('1', '7')  -- 토/일요일 제외
   ;
   

-- 휴일 뺀 이번 월 모든 날짜 뽑기
SELECT mon.*
FROM (SELECT TRUNC(SYSDATE ,'mm') + LEVEL - 1 AS IN_DATE
	FROM DUAL CONNECT BY LEVEL <= SYSDATE - TRUNC(SYSDATE,'mm')) mon
WHERE TO_CHAR(mon.IN_DATE, 'd') NOT IN (1, 7)
;


update OFFICE_HOUR set w_end = SYSDATE 
where emp_uid = 7 AND TO_CHAR(sysdate, 'yyyymmdd') = (
SELECT to_char(W_START, 'yyyymmdd') FROM OFFICE_HOUR WHERE EMP_UID = 7);

SELECT to_char(W_START, 'yyyymmdd') FROM OFFICE_HOUR WHERE EMP_UID = 7;

INSERT INTO OFFICE_HOUR (W_UID, W_START, EMP_UID) VALUES (SEQ_office_hour_w_uid.nextval, sysdate, #{param1});
SELECT W_UID, W_START, EMP_UID FROM  OFFICE_HOUR WHERE EMP_UID = 1 AND TO_CHAR(W_START,'yyyy-mm-dd')= TO_CHAR(SYSDATE, 'yyyy-mm-dd') ;
SELECT COUNT(*) FROM  OFFICE_HOUR WHERE EMP_UID = 1 AND TO_CHAR(W_START,'yyyy-mm-dd')= TO_CHAR(SYSDATE, 'yyyy-mm-dd') ;
SELECT COUNT(*) FROM  OFFICE_HOUR WHERE EMP_UID = 4 AND TO_CHAR(W_END,'yyyy-mm-dd')= TO_CHAR(SYSDATE, 'yyyy-mm-dd') ;
SELECT W_UID, W_START,W_END, EMP_UID FROM  OFFICE_HOUR WHERE EMP_UID = 4;


SELECT  TRUNC(SYSDATE, 'dd' ) FROM dual;

update OFFICE_HOUR set w_end = SYSDATE where emp_uid = 1 AND TO_CHAR(SYSDATE, 'yyyymmdd') = (SELECT to_char(W_START, 'yyyymmdd') FROM OFFICE_HOUR WHERE EMP_UID = 1);
update OFFICE_HOUR set w_end = SYSDATE where emp_uid = 1 AND TO_CHAR(SYSDATE, 'yyyymmdd') = (SELECT to_char(W_START, 'yyyymmdd') FROM OFFICE_HOUR WHERE EMP_UID = 1 AND TO_CHAR(W_START,'yyyy-mm-dd')= TO_CHAR(SYSDATE, 'yyyy-mm-dd'));
update OFFICE_HOUR set w_end = SYSDATE where emp_uid = 1 AND TO_CHAR(W_START,'yyyy-mm-dd') = TO_CHAR(SYSDATE, 'yyyy-mm-dd');

SELECT * FROM OFFICE_HOUR;
SELECT to_char(W_START, 'yyyymmdd') FROM OFFICE_HOUR WHERE EMP_UID = 1 AND TO_CHAR(W_START,'yyyy-mm-dd')= TO_CHAR(SYSDATE, 'yyyy-mm-dd') ;






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
SELECT * FROM HOLIDAY;
8


SELECT TO_CHAR(H_START, 'yyyy-mm') AS "START", TO_CHAR(H_END , 'yyyy-mm') AS "END" FROM HOLIDAY WHERE EMP_UID =2;
	
SELECT A.DT
  FROM (    SELECT TO_CHAR (SDT + LEVEL - 1, 'YYYYMMDD') DT,
                   TO_CHAR (SDT + LEVEL - 1, 'D') D
              FROM (SELECT TO_DATE ((TO_CHAR(SYSDATE , 'YYYY')||'01-01'),'YYYY-MM-DD') SDT,
                           TO_DATE ((TO_CHAR(SYSDATE, 'YYYY')||'12-31'),'YYYY-MM-DD')EDT
                      FROM DUAL)
        CONNECT BY LEVEL <= EDT - SDT + 1) A,
       (
        (SELECT TO_DATE((TO_CHAR( '2020-05-05', 'YYYY-MM-DD') AS DT, '어린이날' CMT FROM DUAL 
       ) B
 WHERE TO_DATE(A.DT, 'YYYY-MM-DD') = B.DT(+) 
    AND A.D NOT IN ('1', '7')  -- 토/일요일 제외
    AND B.DT IS NULL;
   

	
	
	
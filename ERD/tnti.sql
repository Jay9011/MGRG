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

SELECT (h.H_END - h.H_START = 0) "Momth", h.EMP_UID EMP_UID
	FROM HOLIDAY h 
	WHERE h.H_START BETWEEN TO_DATE(TO_CHAR(SYSDATE ,'YYYY') , 'YYYY') AND TO_DATE(TO_CHAR(SYSDATE ,'YYYY') + 1, 'YYYY')
 
SELECT TO_CHAR() FROM HOLIDAY;
	
	
	
	
	
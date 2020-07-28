SELECT h_uid "uid", h_start startTime, h_end endTime, emp_uid emp_uid FROM HOLIDAY WHERE EMP_UID = 1;
SELECT h.h_uid "uid", h.h_start startTime, h.h_end endTime, e."uid" empuid, e.NAME name,e.P_UID puid,e.DEP_UID depuid, e."position" "position", e.DEPARTMENT  departmemt, e."leftHoliday" leftHoliday FROM HOLIDAY h JOIN EMP e ON h.EMP_UID = e."uid" ;
SELECT  * FROM emp;

SELECT e.EMP_UID "uid", category.W_START "start", category.stat "status"
FROM EMPLOYEES e, DEPARTMENT d, POSITIONRANK p,
   (SELECT  
      h.*,
      CASE
         WHEN h.endTime IS NOT NULL THEN '퇴근'
         WHEN h.startTime <= 900 THEN '출근'
         WHEN h.startTime <= 930 THEN '지각'
         ELSE '결근'
         END AS stat
   FROM (SELECT oh.*, TO_NUMBER(TO_CHAR(oh.W_START , 'hh24mi')) AS startTime, 
             to_number(TO_CHAR(oh.W_END , 'hh24mi')) AS endTime
         FROM OFFICE_HOUR oh ) h) category
WHERE e.EMP_UID = category.EMP_UID AND e.DEP_UID = d.dep_uid AND e.P_UID = p.P_UID
ORDER BY category.w_start DESC ;

SELECT e.EMP_UID "uid", category.W_START "start", category.stat "status"
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
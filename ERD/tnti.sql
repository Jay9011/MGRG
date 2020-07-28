SELECT h_uid "uid", h_start startTime, h_end endTime, emp_uid emp_uid FROM HOLIDAY WHERE EMP_UID = 1;
SELECT h.h_uid "uid", h.h_start startTime, h.h_end endTime, e."uid" empuid, e.NAME name,e.P_UID puid,e.DEP_UID depuid, e."position" "position", e.DEPARTMENT  departmemt, e."leftHoliday" leftHoliday FROM HOLIDAY h JOIN EMP e ON h.EMP_UID = e."uid" ;
SELECT  * FROM emp;


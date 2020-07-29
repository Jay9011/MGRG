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
		  WHERE to_char(oh.W_START, 'yyyy-mm-dd') =  '2020-07-29') h) category ON e.EMP_UID = category.EMP_UID
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

CREATE OR REPLACE VIEW statusChart AS
SELECT 

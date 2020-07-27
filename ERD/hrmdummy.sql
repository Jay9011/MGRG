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
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/7)', '<h2><span style="color:#e74c3c;">8월 7일부터는 휴가입니다.</span></h2><pre><span style="color:#e74c3c;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/1)', '<h2><span style="color:#e74c3c;">8월 1일부터는 휴가입니다.</span></h2><pre><span style="color:#e74c3c;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/2)', '<h2><span style="color:#e74c3c;">8월 2일부터는 휴가입니다.</span></h2><pre><span style="color:#e74c3c;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/3)', '<h2><span style="color:#e74c3c;">8월 3일부터는 휴가입니다.</span></h2><pre><span style="color:#e74c3c;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '휴가 관련 공지사항입니다.(8/6)', '<h2><span style="color:#e74c3c;">8월 6일부터는 휴가입니다.</span></h2><pre><span style="color:#e74c3c;">각 부서 팀장님들께서는 휴가 공지를 해주시어 빠르게 처리할 수 있도록 해주십시오</span></pre>',to_date('2020-07-29', 'yyyy-mm-dd'),5);
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
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">인사부 대리 여러분들은 8시 출근이 아닌 8시 30분에 출근해 주십시오</span></h2>', to_date('2020-07-27', 'yyyy-mm-dd'),1,2);
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
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 사원 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 대리 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 팀장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 부장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">영업부 과장 여러분들은 8시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)구조조정 관련 공지 입니다.', '<h2><span style="color:#e74c3c;">실적이 좋지 않은 사원들은 구조조정이 있을 예정입니다.</span></h2>', to_date('2020-03-10', 'yyyy-mm-dd'),4,5);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '사)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부  사원 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,1);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '대)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부 대리 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,2);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '팀)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부 팀장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,3);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '부)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부 부장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,4);
INSERT INTO notice (n_uid, n_subject, n_content,n_regdate,dep_uid,p_uid) 
VALUES (SEQ_notice_n_uid.NEXTVAL, '과)출근시간 변경 공지 입니다.', '<h2><span style="color:#e74c3c;">기술부 과장 여러분들은 9시 30분 출근이 아닌 9시에 출근해 주십시오</span></h2>', to_date('2020-04-12', 'yyyy-mm-dd'),4,5);

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
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-18', 'YYYY-MM-DD'), to_date('2020-07-20', 'YYYY-MM-DD'), 1)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-15', 'YYYY-MM-DD'), to_date('2020-07-18', 'YYYY-MM-DD'), 2)
;
INSERT INTO HOLIDAY (H_UID ,H_START ,H_END ,EMP_UID )
VALUES (SEQ_holiday_h_uid.nextval, to_date('2020-07-23', 'YYYY-MM-DD'), to_date('2020-07-27', 'YYYY-MM-DD'), 1)
;






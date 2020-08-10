/* 고 생 하 셨 습 니 다*/

/* Drop Tables */

DROP TABLE doc_table CASCADE CONSTRAINTS;

/* Drop Sequences */

DROP SEQUENCE seq_uid;


/* Create Sequences */

CREATE SEQUENCE seq_uid;

/* Create Tables */

CREATE TABLE doc_table
(
	doc_uid number NOT NULL,
	doc_title varchar2(30) NOT NULL,
	doc_content clob NULL,
	doc_file varchar2(80) NOT NULL,
	PRIMARY KEY (doc_uid)
);


SELECT * FROM DOC_TABLE ;
DELETE FROM doc_table WHERE doc_uid = 3;

INSERT INTO doc_table VALUES (seq_uid.nextval, '휴가신청서', '휴가신청서 양식입니다', 'requestVacation.hwp');
INSERT INTO doc_table VALUES (seq_uid.nextval, '사유서', '사유서 양식입니다', 'Explaination.hwp');
INSERT INTO doc_table VALUES (seq_uid.nextval, '퇴직증명서', '퇴직증명서 양식입니다', 'retirementVerify.hwp');
INSERT INTO doc_table VALUES (seq_uid.nextval, '회의록', '회의록 양식입니다', 'meetingrecord.docx');
INSERT INTO doc_table VALUES (seq_uid.nextval, '일간스케쥴', '일간스케쥴 양식입니다', 'WorkSchedule.hwp');
INSERT INTO doc_table VALUES (seq_uid.nextval, '근무확인서', '근무확인서 양식입니다', 'WorkCertification.xls');

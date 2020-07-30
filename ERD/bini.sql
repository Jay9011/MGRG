

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

INSERT INTO DOC_TABLE VALUES (seq_uid.nextval, 'gd', '웁스', 'sp');
INSERT INTO DOC_TABLE (doc_uid, doc_title, doc_file) VALUES (seq_uid.nextval, 'gd', 'sp');


SELECT * FROM DOC_TABLE ;
DELETE FROM doc_table WHERE doc_uid = 3;

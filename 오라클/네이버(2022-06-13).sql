-- 네이버 사용자 화면
CREATE TABLE tbl_bbs (
    b_seq NUMBER PRIMARY KEY,
    b_date VARCHAR2(10)  NOT NULL,
    b_time VARCHAR2(10) NOT NULL,	
    b_writer VARCHAR2(125)	NOT NULL,	
    b_subject nVARCHAR2(125) NOT NULL,	
    b_content nVARCHAR2(1000) NOT NULL
);

-- 시작값을 1로 하고, 1씩 자동증가되는 SEQ 생성하기
CREATE SEQUENCE seq_bbs
INCREMENT BY 1 START WITH 1;

SELECT seq_bbs.NEXTVAL  FROM DUAL;
INSERT INTO tbl_bbs(
    b_seq, 
    b_date, 
    b_time, 
    b_writer, 
    b_subject,
    b_content)
VALUES(
    seq_bbs.nextval, 
    '2022-06-13',
    '14:23:00',
    'callor', 
    '게시핀글쓰기',
    '게시판에 글을 쓰자'
);
SELECT * FROM tbl_bbs;


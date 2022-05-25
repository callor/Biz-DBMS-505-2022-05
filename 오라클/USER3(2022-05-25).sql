-- USER3 로 접속한 화면
DROP TABLE tbl_student;
DROP TABLE tbl_dept;
DROP TABLE tbl_belong;

-- 학생정보 테이블
CREATE TABLE tbl_student (
    ST_NUM	    VARCHAR2(8)	PRIMARY KEY,
    ST_NAME	    nVARCHAR2(15)	NOT NULL,
    ST_GRADE	NUMBER(1,0),	
    ST_TEL	    VARCHAR2(15),	
    ST_ADDR	    nVARCHAR2(255)	
);
-- 학과정보 테이블
CREATE TABLE tbl_dept (
    D_CODE	VARCHAR2(5) PRIMARY KEY,
    D_NAME	NVARCHAR2(20) NOT NULL,
    D_PRO	NVARCHAR2(15),
    D_CLASS	VARCHAR2(5 BYTE)
);
-- 소속정보 테이블
CREATE TABLE tbl_belong (
        B_SEQ	NUMBER	PRIMARY KEY,
        B_STNUM	VARCHAR2(8) NOT NULL,
        B_DCODE	VARCHAR2(5) NOT NULL,
        UNIQUE(B_STNUM, B_DCODE)
);

-- 학생정보 샘플데이터 추가
INSERT INTO tbl_student(st_num, st_name, st_grade) VALUES ('20220001', '홍길동',1 );
INSERT INTO tbl_student(st_num, st_name, st_grade) VALUES ('20220002', '이몽룡',3 );
INSERT INTO tbl_student(st_num, st_name, st_grade) VALUES ('20220003', '성춘향',2 );

-- 학과정보 샘플데이터 추가
INSERT INTO tbl_dept(d_code, d_name, d_pro,d_class ) VALUES ('D0001', '컴퓨터공학','장영실','505');
INSERT INTO tbl_dept(d_code, d_name, d_pro,d_class ) VALUES ('D0002', '체육과','임꺽정','501');
INSERT INTO tbl_dept(d_code, d_name, d_pro,d_class ) VALUES ('D0003', '법학과','장영자','502');

-- 소속정보 샘플데이터 추가
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode ) VALUES( 1 , '20220001','D0001');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode ) VALUES( 2 , '20220002','D0001');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode ) VALUES( 3 , '20220002','D0002');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode ) VALUES( 4 , '20220003','D0001');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode ) VALUES( 5 , '20220003','D0002');
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode ) VALUES( 6 , '20220003','D0003');

/*
테이블에 일련번호 칼럼이 있을경우
중복되지 않은 일련번호를 사용하여 PK 로 설정한다
오라클 이외의 다른 DBMS 에서는 AUTO INCREMENT 라는 속성을 사용하여
데이터를 insert 할때 자동으로 칼럼 데이터를 추가한다
하지만 오라클은 그러한 속성이 없어서
상당히 불편하다

오라클에서는 SEQUENCE 라는 특별한 객체가 있어서
그 객체를 사용하여 같은 효과를 발휘한다

또는 PK 해당하는 칼럼을 문자열 32byte 크기로 설정하고
UUID 를 사용하기도 한다
프로그래밍 언어(Java, c, python : 호스트 언어)와 함께
프로젝트를 할때는 UUID를 사용한다
*/
-- seq_belong 이라는 SEQUENCE 객체를 생성하고
-- 시작값을 1로 자동 증가 옵션을 1로 설정하겠다
CREATE SEQUENCE seq_belong
INCREMENT BY 1 START WITH 1 ;

-- seq-_belong SEQUENCE 의 NEXTVAL 값을 조회(SELECT) 하라
-- NEXTVAL 값은 호출(SELECT 등) 할때마다 항상 1증가된 값을 보여준다
SELECT seq_belong.NEXTVAL FROM DUAL;

-- 표준 SQL 에서 간단한 4칙 연산을 수행하는 방법
-- 오라클에서는 SELECT 명령문이 FROM 절이 없이 수행하는 것이 불가능하다
-- 그래서 의미없는(DUMY) Table 인 DUAL Table 을 사용하여 FROM 절을 붙여준다
SELECT 10 + 20 FROM DUAL;
SELECT 100 * 100 FROM DUAL;
SELECT 100 - 10 FROM DUAL;
SELECT 50 / 20 FROM DUAL;

-- SEQUENCE 를 사용하여 자동 증가하는 SEQ 을 만들고, INSERT 에서 사용하기
INSERT INTO tbl_belong (b_seq, b_stnum, b_dcode ) 
VALUES( seq_belong.NEXTVAL, '20220003','D0004');
INSERT INTO tbl_belong (b_seq, b_stnum, b_dcode ) 
VALUES( seq_belong.NEXTVAL, '20220003','D0007');

SELECT * FROM tbl_belong;






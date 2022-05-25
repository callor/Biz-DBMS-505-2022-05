-- 여기는 USER3 화면
-- 학생 Entity 설계를 기준으로 tbl_student table 생성하기
DROP TABLE tbl_student ;
CREATE TABLE tbl_student (
    st_num VARCHAR2(8) PRIMARY KEY,
    st_name nVARCHAR2(15) NOT NULL,
    st_grade NUMBER(1) DEFAULT NULL,
    st_tel VARCHAR2(15),
    st_addr nVARCHAR2(255)
);

INSERT INTO tbl_student (st_num, st_name) 
VALUES( '20220001', '홍길동');

-- 학과 테이블
-- 학과 코드는 PK 로 선언하고
-- 학과이름은 NULL 이거나 중복되지 않도록 설정
DROP TABLE tbl_dept;
CREATE TABLE tbl_dept (

    d_code VARCHAR2(5) PRIMARY KEY,
    d_name nVARCHAR2(20) NOT NULL UNIQUE,
    d_pro nVARCHAR2(15),
    d_class VARCHAR2(5)

);

-- 학생의 학과 소속 정보 Relation 을 Table 로 생성
-- Relation 을 table 로 설계할때 가장 유의 해야 할 부분
-- Entity table 의 칼럼과 DOMAIN(type 과 길이) 을 반드시 일치시켜야 한다

-- 복수의 칼럼이 UNIQUE, NOT NULL 선언되었다
-- 이러한 경우 복수의 칼럼을 묶어 PK 로 선언하기도 한다.
-- 이 Table 에 INSERT 수행할때는 데이터 검증이 잘 되어
-- 잘못된 데이터가 추가되는 것을 방지 할 수 있다

-- 하지만 UPDATE, DELETE 수행할때는
-- 복수의 칼럼으로 조건절을 수행해야 한다.
-- 이때 칼럼을 누락시키거나, 잘못된 값으로 조건을 수행하여
-- 데이터 무결성이 파괴될수 있다

-- 이럴때는 실제 데이터와 관련없는 단일 칼럼을 추가하고
-- PK 설정하는 설계를 할 필요가 있다
DROP TABLE tbl_belong;
CREATE TABLE tbl_belong (
    
    b_seq NUMBER PRIMARY KEY,
    b_stnum VARCHAR2(8) NOT NULL,
    b_dcode VARCHAR2(5) NOT NULL,
    UNIQUE(b_stnum, b_dcode)

);
SELECT * FROM tbl_student;

-- 전체 칼럼에 데이터 포함하여 INSERT 하기
INSERT INTO tbl_dept(d_code, d_name, d_pro, d_class)
VALUES('D0001','컴퓨터공학','홍길동','505');

-- 전체 칼럼에 데이터를 포함항 ISNERT 할때는 칼럼 리스트를 생략할수 있다
-- 하지만, 정확히 칼럼에 데이터들이 일치하는 보장이 없다
INSERT INTO tbl_dept
VALUES('D0002','전자공학','이몽룡','506');

-- 학번 1번학생의 소속학과(D0001)을 등록
INSERT INTO tbl_belong(b_seq, b_stnum, b_dcode)
VALUES(1,'20220001','D0001');

-- 학생들의 소속학과(코드)를 확인하는 JOIN 문
SELECT ST.st_num, ST.st_name, B.b_dcode, ST.st_grade
FROM tbl_student ST
    LEFT JOIN tbl_belong B
        ON ST.st_num = B.b_stnum;


INSERT INTO tbl_student(st_num, st_name)        VALUES ('20220001','홍길동');
INSERT INTO tbl_belong(b_seq,b_stnum, b_dcode ) VALUES(1,'20220001','D0001');
INSERT INTO tbl_dept(d_code, d_name )     VALUES('D0001','컴퓨터공학');

SELECT ST.st_num, ST.st_name, 
        B.b_dcode,D.d_name, D.d_pro,
        ST.st_grade, D.d_class
FROM tbl_student ST
    LEFT JOIN tbl_belong B
        ON ST.st_num = B.b_stnum
    LEFT JOIN tbl_dept D
        ON B.b_dcode = D.d_code;









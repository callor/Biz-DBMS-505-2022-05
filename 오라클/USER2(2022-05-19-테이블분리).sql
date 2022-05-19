SELECT * FROM  tbl_score
WHERE sc_subject = '영어';

/*
성적데이터가 저장된 tbl_score table 의 데이터중
영어과목을 영어영문으로 변경하고 싶다
SQL UPDATE 명령을 이용하면 간단히 해결할수 있다

하지만 현재 table 에서 100개의 레코드(데이터들)이 변경되는 문제가 발생한다
한번에 다량의 레코드의 데이터가 변경되는 경우
데이터 무결성, transaction 등의 문제를 일으킬 수 있다

자주 일어나는 상황은 아니지만 이러한 상황이 발생하지 않도록 하기 위하여
table 설계를 다시 수행해야 한다.
*/
UPDATE tbl_score
SET sc_subject = '영어영문'
WHERE sc_subject = '영어';

/*
tbl_score 테이블의 초기 설계 오류로 인하여 과목명이 일반 문자열로 등록되었다
만약 과목명을 변경하려면 많은 데이터를 변경해야 하기 때문에
문제를 일으킬 것이다

tbl_score 테이블의 설계를 변경하여
과목정보 테이블을 생성하고
과목정보와 연계하여 과목명을 볼수 있도록 하겠다
*/
-- tbl_score 에서 과목명만 추출하기
-- tbl_score 에서 과목명을 중복없이 추출하기
SELECT sc_subject
FROM tbl_score
GROUP BY sc_subject
ORDER BY sc_subject;

-- tbl_score 에서 학번만 중복없이 추출하기
SELECT sc_stnum
FROM tbl_score
GROUP BY sc_stnum
ORDER BY sc_stnum;

-- 추출한 과목명을 엑셀에 복사하여
-- 과목코드를 부여한 데이터를 확보했다

-- 과목정보를 저장할 테이블 생성
DROP TABLE tbl_subject;
CREATE TABLE tbl_subject (
    sb_code	VARCHAR2(5)	NOT NULL PRIMARY KEY,
    sb_name	nVARCHAR2(25) NOT NULL	
);

-- 테이블에 데이터 import
-- import 한 데이터 확인
SELECT * FROM tbl_subject;

-- 고객에게 시스템 정비가 있다는 공지 문자 보내기

-- tbl_score 테이블의 구조변경하기
/*
SQL DDL(data definition)  명령
CREATE(새로운 객체생성), DROP(객체 제거), ALTER(객체의 구조변경)
    객체(테이블)의 구조를 변경하는 것은 상당히 많은 위험과 비용을 유발한다
    테이블의 구조를 변경하는 것은 데이터의 무결성을 심각하게 위협할 수 있다

1. tbl_score에 sc_sbcode "칼럼을 추가"하기
*/
ALTER TABLE tbl_score
ADD sc_sbcode VARCHAR2(5);

DESC tbl_score;

SELECT * 
FROM tbl_score;

-- projection : 칼럼을 원하는 것만, 원하는 순서로 보여달라
SELECT sc_seq, sc_stnum, sc_sbcode, sc_subject, sc_score
FROM tbl_score;

-- sub query
-- query 가 다른 query 의 결과를 포함하는 구조
SELECT sc_seq, sc_stnum, 
(
    SELECT sb_code FROM tbl_subject 
    WHERE sc_subject = sb_name
) AS sb_code,
sc_subject, sc_score
FROM tbl_score;

-- 2. sub query 를 사용하여
-- tbl_subject table 로 부터 과목코드를 가져와서
-- tbl_score 테이블에 update 실행하기

-- 아래 명령은 전체 데이터의 sc_sbcode 칼럼의 값을 001 문자열로 대체한다
-- 드디어 일주일간 야근이다
-- 경고 : UPDATE 와 DELETE 명령은 WHERE 이 없을때 절대 실행 금지~~~!!!!
UPDATE tbl_score
SET sc_sbcode = '001';

UPDATE tbl_score
SET sc_sbcode =
(
    SELECT sb_code
    FROM tbl_subject
    WHERE sc_subject = sb_name
);   

SELECT * FROM tbl_score;

-- 3. UPDATE 후 데이터 검증
-- tbl_score table 의 과목명과 
-- tbl_subject table 의 과목명이 일치하지 않아
-- UPDATE 가 되지 않은 데이터가 있는지 확인
SELECT *
FROM tbl_Score
WHERE sc_sbcode = '001';

-- 칼럼을 처음추가한 상태에서는 null 값이 담겨 있으므로
-- 칼럼의 값이 null 인 데이터만 조회해 본다
-- 결과는 없어야 한다
SELECT *
FROM tbl_score
WHERE sc_sbcode IS NULL;

-- 4. 새로 생성된 칼럼에 제약조건 설정
-- 새로 생성한 과목코드(sc_sbcode) 칼럼은 값이 비어있으면 곤란한 상황이 발생할 수 있다
-- 학번과 점수는 있는데 과목코드가 없으면 조회한 데이터에 문제가 있을 수 있다
-- 또한 점수를 입력하지 않은 것으로 생각하고
-- 반복하여 값을 저장할 수 있다
-- 새로 생성한 칼럼을 NOT NULL 로 설정한다
-- NOT NULL 제약 조건 : 값을 INSERT 할때 이 칼럼은 비워 놓아서는 안된다
ALTER TABLE tbl_score MODIFY (sc_sbcode NOT NULL);
-- 이후 부터 데이터를 INSERT 할때 sc_sbcode 칼럼의 데이터가 없으면 INSERT 까 거부된다


-- 5. tbl_score 테이블에서 sc_subject(과목명) 칼럼은 필요가 없게 되었다
-- 조금이라도 저장공간을 절약하기 위하여 칼럼을 삭제 하기
ALTER TABLE tbl_score DROP COLUMN sc_subject;
DESC tbl_score;

-- DBMS 에서는 길이가 같은 문자열은 부등호 조건으로 결과를 조회할수 있다
SELECT *
FROM tbl_score
WHERE sc_stnum <= 'S0003'
ORDER BY sc_stnum ;

-- EQ(equal) JOIN
/*
완전 JOIN
main table 과 참조(foregn) table 간에
완전참조 무결성이 유지되는 경우에만
결과에 신뢰성이 유지 된다

만약 main table 에는 데이터가 있는데
참조하는 값이 참조 table 에 없는경우
결과는 main table 의 데이터가 조회되지 않는다

*/
SELECT sc_stnum AS 학번, sc_sbcode AS 과목코드, 
        sb_name AS 과목명, sc_score AS 점수
FROM tbl_score, tbl_subject
WHERE sc_sbcode = sb_code 
ORDER BY sb_name ;

SELECT * FROM tbl_score
WHERE sc_sbcode = 'SB001';

DELETE FROM tbl_subject
WHERE sb_code = 'SB001';

INSERT INTO tbl_subject ( sb_code, sb_name ) 
VALUES ('SB001','국어');
COMMIT ;

-- JOIN 실습

-- EQ JOIN 
SELECT sc_stnum AS 학번, sc_sbcode AS 과목코드, 
        sb_name AS 과목명, sc_score AS 점수
FROM tbl_score, tbl_subject
WHERE sc_sbcode = sb_code 
ORDER BY sb_name ;

DELETE FROM tbl_subject
WHERE sb_code = 'SB001';

-- 참조 무결성이 유지되지 않은 table 간에 JOIN
-- 현재 tbl_subject table 에는 SB001 데이터가 삭제된 상태이다
-- tbl_score 에는 SB001 과목의 데이터들이 있다
-- 이 상태에서는 EQ JOIN 결과는 신뢰할 수 없다
-- 이러한 경우에는 OUTTER JOIN 을 사용해야 한다

-- (OUTTER) LEFT JOIN
-- main table 과 참조 table 간에 참조무결성이 유지되지 않는 경우 사용
-- main table 은 [조건에 따라] 데이터를 전부 나열하고
-- 참조 table 에서 ON 조건에 맞는 데이터를 조회한다
-- 참조 table 에 ON 조건에 맞는 데이터가 있으면 데이터를 가져오고
--      없으면 null 값을 가져온다

SELECT sc_stnum AS 학번, sc_sbcode AS 과목코드, 
        sb_name AS 과목명, sc_score AS 점수
FROM tbl_score
    LEFT JOIN tbl_subject
        ON sc_sbcode = sb_code
WHERE sc_stnum <= 'S0003'        
ORDER BY sc_sbcode;        
ROLLBACK;

-- 카티션 곱
-- 무조건 JOIN
-- JOIN 된 table 의 모든 데이터를 곱셈한 것처럼 리스트 출력
-- 다수의 table 에 저장된 데이터의 개수를 한번에 확인하기
SELECT COUNT(*) FROM tbl_score, tbl_subject;







USE schoolDB;
CREATE TABLE tbl_student (
	st_num	VARCHAR(5)		PRIMARY KEY,
	st_name	VARCHAR(20)	NOT NULL,	
	st_dept	VARCHAR(20),		
	st_grade	INT,		
	st_tel	VARCHAR(15)	NOT NULL,	
	st_addr	VARCHAR(125)		
);
SELECT COUNT(*) FROM tbl_student;

CREATE TABLE tbl_subject (
	sb_code	VARCHAR(5)	NOT NULL	PRIMARY KEY,
	sb_name	VARCHAR(25)	NOT NULL	
);
-- MySQL 의 다중 INSERT
INSERT INTO tbl_subject(sb_code, sb_name)
VALUES
('SB001','국어'),
('SB002','데이터베이스'),
('SB003','미술'),
('SB004','소프트웨어공학'),
('SB005','수학'),
('SB006','영어영문'),
('SB007','음악');
SELECT * FROM tbl_subject;

-- 성적이 저장될 table
-- 학생정보와 과목정보가 함께 연동되어 점수를 관리
-- sc_seq 임의 칼럼을 만들어 PK 로 삼고
-- 학번 + 과목코드가 동시에 같은 코드가 중복되지 않도록
-- UNIQUE(학번, 과목코드) 설정하였다
CREATE TABLE tbl_score (
	sc_seq	BIGINT PRIMARY KEY AUTO_INCREMENT,
	sc_stnum	VARCHAR(5)	NOT NULL,	
	sc_sbcode	VARCHAR(5)	NOT NULL,	
	sc_score	INT,
    UNIQUE(sc_stnum, sc_sbcode)
);
SELECT COUNT(*) FROM tbl_score;

-- tbl_score 데이터에서 점수가  70점 이하인 데이터만 추출
-- 학번순으로 리스트를 나열하기
-- Selection : 조건절(WHERE)을 추가하여 조건에 맞는 데이터만 추출하기
SELECT * FROM tbl_score
WHERE sc_scode <= 70
ORDER BY sc_stnum;

-- tbl_score 데이터에서 전체데이터를 표시하되
-- 과목코드, 점수 칼럼만 표시되도록 

-- Projection
-- table 많은 칼럼(속성 Attribute, 필드 field)이 있을경우
-- 필요한 칼럼만 나열하여 리스트를 보고자 할때
SELECT sc_sbcode AS 과목코드, sc_score AS 점수
FROM tbl_score;

-- tbl_score 데이터에서 점수가 
-- 50점 이상 70점 이하인 데이터
-- 과목코드와 점수만 보이도록 
SELECT sc_sbcode AS 과목코드, sc_score AS 점수
FROM tbl_score
WHERE sc_score >= 50 AND sc_score <= 70;

-- 범위를 지정할때 이상 AND 이하 일경우 BETWEEN 을 사용할 수 있다
SELECT sc_sbcode AS 과목코드, sc_score AS 점수
FROM tbl_score
WHERE sc_score BETWEEN 50 AND 70;
-- WHERE 50 <= sc_score <= 70

-- 점수가 50이상 70이하인 데이터
-- tbl_subject table 과 연결하여
-- 과목코드, 과목명, 점수 칼럼이 보이도록 
SELECT sc_sbcode, sc_score
FROM tbl_score, tbl_subject
WHERE sc_sbcode = sccode AND sc_score BETWEEN 50 AND 70;

-- tbl_score 테이블에서 WHERE 조건에 맞는 데이터를 모두 Section 하고
-- tbl_subject 테이블에서 ON 조건에 맞는 데이터만 Section 하여 같이표시
SELECT SC.sc_sbcode,SB.sb_name, SC.sc_score
FROM tbl_score SC
	LEFT JOIN tbl_subject SB
		ON SC.sc_scbcode = SB.sb_code
WHERE SC.sc_score BETWEEN 50 AND 70;

-- 점수가 50 ~ 70 인 데이터를 Selection
-- 과목코드, 과목명, 점수를 표현
-- tbl_student table 을 JOIN 하고
-- 학번, 학생이름, 과목코드, 과목명, 점수를 Projection
-- 학번 순으로 정렬하기
SELECT SC.sc_stnum AS 학번, 
		ST.st_name AS 이름,
        SC.sc_sbcode AS 과목,
        SB.sb_name AS 과목명, 
        SC.sc_score AS 점수
FROM tbl_score SC
	LEFT JOIN tbl_subject SB
		ON SC.sc_sbcode = SB.sb_code
	LEFT JOIN tbl_student ST
		ON SC.sc_stnum = ST.st_num
WHERE SC.sc_score BETWEEN 50 AND 70;

-- tbl_score 테이블에서 과목별 총점 구하기
-- GROUP BY SUM, AVG 등 통계함수를 사용하여 Selection
SELECT sc_sbcode AS 과목코드, 
		SUM(sc_score) AS 총점, 
        AVG(sc_score) AS 평균
FROM tbl_score
GROUP BY sc_sbcode;

-- 과목명을 함께 Projection
SELECT sc_sbcode AS 과목코드, 
		sb_name AS 과목명,
		SUM(sc_score) AS 총점, 
        AVG(sc_score) AS 평균
FROM tbl_score
	LEFT JOIN tbl_subject
		ON sc_sbcode = sb_code
GROUP BY sc_sbcode,sb_name;

-- 학생별로 총점, 평균 구하기
-- 학번, 이름, 총점, 평균 Projection
-- 학번순으로 정렬
SELECT sc_stnum, st_name, SUM(sc_score), AVG(sc_score)
FROM tbl_score
	LEFT JOIN tbl_student
		ON sc_stnum = st_num
GROUP BY sc_stnum;

SELECT st_num, st_name,sc_sbcode, sc_score
FROM tbl_student ST
	LEFT JOIN tbl_score SC
		ON ST.st_num = SC.sc_stnum;

-- tbl_score 테이블에서 각 학생들의 SB002(데이터베이스) 과목 점수만
--  학번    데이터베이스점수(SB002)
--  S0001   90
--  S0002   70
--  S0003   90
SELECT st_num, st_name,sc_sbcode, sc_score
FROM tbl_student ST
	LEFT JOIN tbl_score SC
		ON ST.st_num = SC.sc_stnum
WHERE sc_sbcode = 'SB002';        
/*
SB003	미술
SB004	소프트웨어공학
SB005	수학
SB006	영어영문
SB007	음악
*/
SELECT sc_stnum,st_name,
	SUM(IF(sc_sbcode = 'SB001',sc_score,0)) AS 국어,
    SUM(IF(sc_sbcode = 'SB002',sc_score,0)) AS DB,
    SUM(IF(sc_sbcode = 'SB003',sc_score,0)) AS 미술,
    SUM(IF(sc_sbcode = 'SB004',sc_score,0)) AS 소프트웨어공학,
    SUM(IF(sc_sbcode = 'SB005',sc_score,0)) AS 수학,
    SUM(IF(sc_sbcode = 'SB006',sc_score,0)) AS 영어영문,
    SUM(IF(sc_sbcode = 'SB007',sc_score,0)) AS 음악
FROM tbl_score
	LEFT JOIN tbl_student
		ON sc_stnum = st_num
GROUP BY sc_stnum, st_name;

SELECT sc_stnum,st_name,
	SUM( CASE WHEN sc_sbcode = 'SB001' THEN sc_score ELSE 0 END ) AS 국어,
    SUM( CASE WHEN sc_sbcode = 'SB002' THEN sc_score ELSE 0 END ) AS DB,
    SUM( CASE WHEN sc_sbcode = 'SB003' THEN sc_score ELSE 0 END ) AS 미술,
    SUM( CASE WHEN sc_sbcode = 'SB004' THEN sc_score ELSE 0 END ) AS 소프트웨어공학,
    SUM( CASE WHEN sc_sbcode = 'SB005' THEN sc_score ELSE 0 END ) AS 수학,
    SUM( CASE WHEN sc_sbcode = 'SB006' THEN sc_score ELSE 0 END ) AS 영어영문,
    SUM( CASE WHEN sc_sbcode = 'SB007' THEN sc_score ELSE 0 END ) AS 음악
FROM tbl_score
	LEFT JOIN tbl_student
		ON sc_stnum = st_num
GROUP BY sc_stnum, st_name;

/*
 제2정규화가 되어있는  데이터를 view 할때는 PIVOT으로 데이터를
 펼처서 보는 것이 편리할 때가 많다
 제2정규화가 된 데이터는 기준이되는 키값을 중심으로 Row 방향으로
 데이터가 저장되어 있다
 이 데이터를 쉽게 보고서등으로 만들때는 PIVOT을 하여
 Column 방향으로 펼처서 보는것이 편리하다
*/

SELECT sc_stnum,
group_concat(sc_score)
FROM tbl_score
GROUP BY sc_stnum;

DESC tbl_student;
DESC tbl_score;
DESC tbl_subject;












-- tbl_score table 의 데이터를 참조하여
-- 과목별 전체 총점을 구하시오







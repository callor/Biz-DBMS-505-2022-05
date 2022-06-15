-- 여기는 Selfit 사용자 화면
CREATE TABLE tbl_sch (
    sc_id	VARCHAR2(4)		PRIMARY KEY,
    sc_num	VARCHAR2(6)	NOT NULL,	
    sc_label	nVARCHAR2(10)	NOT NULL,	
    sc_division	nVARCHAR2(20)	NOT NULL,	
    sc_day	VARCHAR2(10)	NOT NULL,	
    sc_part	nVARCHAR2(30)	NOT NULL	
);

CREATE TABLE tbl_list (
    list_id	VARCHAR2(5)		PRIMARY KEY,
    list_name	nVARCHAR2(125)	NOT NULL	
);


DROP TABLE tbl_sch_list;
CREATE TABLE tbl_sch_list (
    sl_id	VARCHAR2(5)		PRIMARY KEY,
    sl_scid	VARCHAR2(4)	NOT NULL,	
    sl_listid	VARCHAR2(5)	NOT NULL,	
    sl_listname	nVARCHAR2(125)	NOT NULL,	
    sl_set	NUMBER	NOT NULL,	
    sl_weight	VARCHAR2(10)	NOT NULL,	
    sl_rep	VARCHAR2(10)	NOT NULL	
);

SELECT COUNT(*) FROM tbl_sch;
SELECT COUNT(*) FROM tbl_list;
SELECT COUNT(*) FROM tbl_sch_list;


SELECT * FROM tbl_sch_list;

DROP VIEW view_workout;
CREATE VIEW view_WorkOut
AS (
SELECT sl_id,sl_scid, 
            sc_num, sc_label, sc_division, sc_day, sc_part,
        sl_listid, list_name,
        sl_set, sl_weight, sl_rep
FROM tbl_sch_list
    LEFT JOIN tbl_sch
        ON sc_id = sl_scid
    LEFT JOIN tbl_list
        ON list_id = sl_listid
);        

SELECT * FROM view_Workout        
ORDER BY sc_num, sc_day;        

SELECT sc_num, sc_label
FROM view_workout
GROUP BY sc_num, sc_label
ORDER BY sc_num;

SELECT sc_label
FROM view_workout
GROUP BY sc_label;

SELECT sc_label,sc_part
FROM view_workout
WHERE sc_label = '초급';
        
-- 운동스케쥴 table 에서 등급ID + Label + Division 이를 묶어서 한개씩만 보고 싶을 때
SELECT sc_num, sc_label, sc_division
FROM tbl_sch
GROUP BY sc_num, sc_label, sc_division
ORDER BY sc_num;

SELECT sc_num, sc_label, sc_division,sc_day, sc_part
FROM tbl_sch
WHERE sc_num = '01-001'
ORDER BY sc_num;

SELECT * FROM view_workout
WHERE sl_scid = 'D040'
ORDER BY sc_num, sc_day;

SELECT * FROM view_workout
WHERE sl_listid = 'PN011'
ORDER BY sc_num, sc_day;        







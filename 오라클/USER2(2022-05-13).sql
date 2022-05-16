-- USER2 화면

SELECT * FROM tbl_student
WHERE st_num = 'S0101';

SELECT SUBSTR(st_name,1,1) || '*' || SUBSTR(st_name,-1,1) AS st_name FROM tbl_student
WHERE st_num = 'S0101';

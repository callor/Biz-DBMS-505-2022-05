use mydb;
DROP TABLE tbl_users;
DROP TABLE tbl_authorities;

DESC tbl_users;
DESC tbl_authorities;
SELECT * FROM tbl_authorities;
SELECT * FROM tbl_users;

UPDATE tbl_users
SET enabled = true
WHERE username = 'callor';





CREATE DATABASE mytodoDB;
USE mytodoDB;

DROP TABLE tbl_users;
CREATE TABLE tbl_users (
	username VARCHAR(20) PRIMARY KEY,
	password VARCHAR(255) NOT NULL,
	enabled BOOLEAN DEFAULT FALSE,
	accountNonExpired BOOLEAN  DEFAULT FALSE,
	accountNonLocked BOOLEAN  DEFAULT FALSE,
	credentialsNonExpired BOOLEAN  DEFAULT FALSE,
	realname VARCHAR(20),
	nickname VARCHAR(20)
);
DESC tbl_users;

DROP TABLE tbl_authorities;
CREATE TABLE tbl_authorities (
	seq BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(20),
    authorty VARCHAR(20)
);

SHOW TABLES;

INSERT INTO tbl_users(username, password, enabled)
VALUE('callor88','1234',true);

INSERT INTO tbl_authorities(username,authorty)
VALUES('callor88','ROLE_ADMIN');
INSERT INTO tbl_authorities(username,authorty)
VALUES('callor88','ROLE_USER');

DROP TABLE  tbl_todolist;
CREATE TABLE tbl_todolist (
	t_seq BIGINT AUTO_INCREMENT PRIMARY KEY,
    t_username VARCHAR(20) NOT NULL,
    t_sdate VARCHAR(10) NOT NULL,
    t_stime VARCHAR(10) NOT NULL,
    t_edate VARCHAR(10),
    t_etime VARCHAR(10)
);
USE mytodoDB;
SELECT * FROM tbl_authorities;
SELECT *  FROM tbl_users;

DROP TABLE tbl_users;
DROP TABLE tbl_authorities;
DROP TABLE tbl_todoList;

SHOW TABLES;

SELECT * FROM tbl_todolist;




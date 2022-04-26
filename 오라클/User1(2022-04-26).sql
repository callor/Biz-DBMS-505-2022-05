SELECT 30 + 40 FROM DUAL;
CREATE TABLE tbl_book (
    b_name varchar2(100)
);

DESCRIBE tbl_book;

SELECT * FROM tbl_book;
INSERT INTO tbl_book(b_name)
VALUES('자바야 놀자');
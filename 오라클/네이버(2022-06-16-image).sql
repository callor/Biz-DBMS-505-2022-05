CREATE TABLE tbl_images(
    i_seq NUMBER PRIMARY KEY,
	i_bseq NUMBER NOT NULL,
	i_originalName VARCHAR2(255),
	i_imageName VARCHAR2(255)
);
CREATE SEQUENCE seq_image 
INCREMENT BY 1 START WITH 1;

SELECT * FROM tbl_bbs, tbl_images
WHERE b_seq = i_bseq;



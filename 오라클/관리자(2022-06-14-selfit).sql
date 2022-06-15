-- 여기는 관리자 화면
-- selfit 데이터 저장 공간 생성
CREATE TABLESPACE selfitDB
DATAFILE 'C:/oraclexe/data/selfit.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER selfit IDENTIFIED BY selfit
DEFAULT TABLESPACE selfitDB;

GRANT DBA TO selfit;
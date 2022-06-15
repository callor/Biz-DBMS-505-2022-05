-- 관리자 접속화면

-- TableSpace : 새로운 프로젝트를 만들때 프로젝트의 데이터가 저장될 파일 생성
-- naverDB 이름으로 초기 용량은 1MB 부족할 경우 1KB 씩 자동증가
-- naverdb.dbf 파일로 저장하라
CREATE TABLESPACE naverDB
DATAFILE 'C:/oraclexe/data/naverDB.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- 사용자 등록
-- 사용자 등록할때 DEFAULT TABLESPACE 를 지정하지 않으면
-- System Tablespace에 데이터를 저장하게 되어 문제가 될수 있다
CREATE USER bookuser IDENTIFIED BY bookuser
DEFAULT TABLESPACE naverDB;

GRANT DBA TO bookuser;

-- 관리자 화면
-- TableSpace 생성하기
-- 이름 : iolist
-- 데이터파일(물리적저장소) C:/oraclexe/data/iolist.dbf
-- 초기크기 : 1MB
-- 용량이 부족할 경우 : 자동증가 1KB 씩
CREATE TABLESPACE iolist
DATAFILE 'C:/oraclexe/data/iolist.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- TableSpace 삭제하기
DROP TABLESPACE iolist
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

-- 사용자 생성
-- username : user3, password : 12341234
-- Default tablespace : 이 사용자 계정으로 데이터를 추가하면 
--      iolist 에 저장하라
CREATE USER user3 IDENTIFIED BY 12341234
DEFAULT TABLESPACE iolist;

-- 사용자 계정 완전 삭제하기
DROP USER user3 CASCADE;

-- 사용자 등록을 완료했으나 현재는 아무런 일도 할수 없는 상태이다
-- 사용자에게 DB 연결, 조회, 추가, 삭제, 변경 등을 할수 있는 권한을 부여해야 한다
-- 원칙은 권한을 세세하게 부여하여 불필요한 권한을 갖지 않도록 해야 하지만
-- 학습상 불편함이 있어서 여기서는 DBA 권한을 부여할 것이다
GRANT DBA TO user3; -- 권한 부여하기
REVOKE DBA FROM user3; -- 권한 회수하기






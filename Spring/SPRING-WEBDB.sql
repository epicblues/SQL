-- 사용자 생성--

CREATE USER C##WEBDB IDENTIFIED BY webdb;

-- CONNECT RESOURCE 권한

GRANT CONNECT, RESOURCE TO C##WEBDB;
-- 접속 권한


-- 테이블 스페이스 생성(12이상)
ALTER USER C##WEBDB DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;




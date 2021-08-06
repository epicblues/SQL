-----------------
-- DDL(데이터 정의어)
-----------------
-- C##BITUSER로 진행

-- 현재 내가 소유한 테이블 목록
SELECT * FROM tab;
-- 현재 내게 주어진 ROLE
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE LIKE 'C##%';

-- 테이블 생성
CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date date default SYSDATE  
);

select * from tab;
DESC book; -- 테이블 정의 정보 확인

-- 서브쿼리를 이용한 테이블의 생성
-- HR 스키마의 employees 테이블의 일부 데이터를 추출, 새 테이블 생성.
-- job_id가 IT 관련된 직원만 뽑아내서 새 테이블 생성.
SELECT * FROM hr.employees
WHERE job_id like 'IT%';

CREATE TABLE it_emps as (
    SELECT * FROM hr.employees
    WHERE job_id like 'IT%'
);


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
WHERE job_id like '%IT%';

CREATE TABLE it_emps as (
    SELECT * FROM hr.employees
    WHERE job_id like 'IT_%'
);

DESC it_Emps;
SELECT * FROM IT_EMPS;

DROP TABLE IT_EMPS; -- 테이블 삭제

-- author 테이블 추가
CREATE TABLE author (
    author_id number(10),
    author_name NVARCHAR2(50) NOT NULL, -- 컬럼 제약
    author_desc VARCHAR2(500), -- 컬럼 정의 끝, 테이블 제약 시작
    PRIMARY KEY (author_id) -- 테이블 제약, 자동으로 not null 설정
);

desc author;
desc book;

-- book 테이블에서 author 컬럼 지우기
-- 나중에 author 테이블과 FK로 연결
DESC book;
ALTER TABLE book DROP(author);

-- author 테이블 참조를 위한 컬럼 author_id 추가
ALTER TABLE book ADD(author_id number(10));
-- book 테이블의 book_id NUMBER(10)으로 변경
ALTER TABLE book MODIFY(book_id number(10));

desc author;
desc book;

-- book 테이블의 book_id에 pk 제약조건 부여

ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY (book_id);

-- book.author_id 를 author.author_id를 참조하도록 제약
ALTER TABLE book
ADD CONSTRAINT fk_author_id FOREIGN KEY (author_id)
                        REFERences author(author_id)
                        ON DELETE CASCADE;


-- DATA DICTIONARY
-- 전체 데이터 딕셔너리 확인
SELECT * FROM DICTIONARY;

-- 사용자 SCHEMA 객체 확인 : USER_OBJECTS
SELECT * FROM USER_OBJECTS;

-- 제약조건 : USER_CONSTRAINTS
SELECT * FROM USER_CONSTRAINTS;


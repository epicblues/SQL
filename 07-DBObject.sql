---------
-- DB OBJECT
---------

-- VIEW
-- System 계정으로 수행
-- create view 권한 필요
grant create view to C##bituser;

--C##BITUSER 전환
-- HR.employees 테이블로부터 department_id = 10인 사원의 뷰

CREATE TABLE emp_123
 AS select * from Hr.employees where department_id in (10,20,30);

-- Simple View 생성
CREATE OR REPLACE VIEW emp_10
AS (select employee_id,first_name,last_name,salary 
from emp_123 where department_id = 20);

desc emp_10;

-- 마치 일반 테이블처럼 SELECT 할 수 있다.
SELECT employee_id, first_name, salary from emp_10;

-- Simple View 는 제약 사항에 위배되지 않는다면 내용을 갱신할 수 있다.
UPDATE emp_10 set salary= salary*2;
select first_name, salary from emp_123 where department_id = 30;

-- 가급적 View는 조회 전용으로 사용하기를 권장.
-- WITH READ ONLY 옵션 

CREATE OR REPLACE VIEW emp_30 AS 
SELECT employee_id, first_name, last_name, salary FROM emp_123
WHERE department_id = 30
WITH READ ONLY;

UPDATE emp_30 set salary=salary*2;

-- Complex View 
CREATE OR REPLACE VIEW book_detail 
    (book_id, title, author_name, pub_date)
    AS SELECT book_id, title, author_name, pub_date 
        FROM book b, author a 
        WHERE b.author_id = a.author_id;
        
SELECT * FROM author;

DESC book;
select * from book;
INSERT INTO book(book_id,title,author_id) values(1,'토지',1);
INSERT INTO book(book_id,title,author_id) values(2,'살인자의 기억법',2);

select * from book_detail;

-- Complex View는 갱신이 불가
UPDATE book_detail SET author_name = '소설가'; -- ERROR

-- View의 삭제
-- book detail은 book, author 테이블을 기반으로 함.
drop view book_detail; -- VIEW 삭제

SELECT * FROM USER_OBJECTs;

-- VIEW 확인을 위한 DICTIONARY
SELECT * FROM USER_VIEWS;

SELECT object_name, created, status from USER_OBJECTS WHERE object_type = 'VIEW';

-- INDEX : 검색 속도 증가
-- INSERT, UPDATE, DELETE -> 인덱스의 갱신이 일어난다.
-- hr.employees 테이블을 복사 -> s_emp 테이블 생성

CREATE TABLE s_emp as SELECT * from hr.EMPLOYEES;
SELECT * FROM s_emp;

-- s_emp.employeed_id에 UNIQUE_INDEX 부여
CREATE UNIQUE INDEX s_emp_id
    ON s_emp (employee_id);

-- INDEX를 위한 DICTIONARY;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS; -- COLUMN_POSITION 컬럼 위치.

-- 어느 테이블에 어느 컬럼에 S_EMP_ID가 부여되었는가?

SELECT t.index_name, t.table_name, c.column_name, c.column_position 
FROM USER_INDEXES t, USER_IND_COLUMNS c WHERE t.index_name = c.index_name
 AND c.index_name = 'S_EMP_ID';
 
 -- 인덱스 삭제
 DROP INDEX s_emp_id;
  SELECT * FROM USER_INDEXES;
  SELECT * FROM S_emp;
  
  -- 인덱스는 테이블과 독립적이다. 다양한 방법으로 인덱스를 사용해도 지장 없음. 
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

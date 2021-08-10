-----------
-- CUD
-----------

-- insert : 묵시적 방법
DESC author;
INSERT INTO author 
values(1, '박경리', '토지 작가');

-- INSERT : 명시적 방법(컬럼 명시)
INSERT INTO author
(author_id, author_name)
VALUES (3, '김선수');

-- 확인
select * from author;

-- DML은 트랜잭션의 대상이다.
-- 취소 : ROLLBACK;
-- 변경 사항 반영 : COMMIT을 입력.
ROLLBACK;
select * from author;
COMMIT; -- 변경사항 반영

-- UPDATE
-- 기존 레코드의 내용을 변경한다.
UPDATE author set author_desc = '소설가'; -- 모든 row가 다 바뀌었다(주의(
ROLLBACK;

-- UPDATE DELETE 쿼리 작성시 
-- 조건절을 부여하지 않으면 전체 레코드가 영향을 받는다.
UPDATE author set author_desc = '소설가'
WHERE author_name = '김영하';
COMMIT;

-- 연습
-- HR.employees table로 부터 department_id가 10, 20, 30
-- 새 테이블 생성

CREATE table emp123 as (
    select * from hr.employees where department_id in (10, 20, 30)
);

desc emp123;
select * from emp123;

-- 부서가 30인 사원들의 급여를 10% 인상

UPDATE emp123 set salary = salary*1.1 
WHERE department_id = 30;

-- DELETE : 테이블에서 레코드 삭제
select * from emp123;

-- job_id가 mk로 시작하는 사원들 삭제
DELETE from emp123 where job_id like 'MK%';

-- 현재 급여 평균보다 급여가 높은 사람 모두 삭제
DELETE FROM emp123 where salary >(select avg(salary) from emp123); 

COMMIT;

-- TRUNCATE 와 DELETE의 차이
-- DELETE는 ROLLBACK의 대상이다.
-- TRUNCATE는 ROLLBACK의 대상이 아니다.

select * from emp123;

delete from emp123;
rollback;

TRUNCATE TABLE emp123;
select * from emp123;

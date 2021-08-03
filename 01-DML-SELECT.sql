-- DML - SELECT

------------
-- SELECT * FROM
------------

------------

-- 전체 데이터의 모든 컬럼 조회
-- 컬럼의 출력 순서는 정의에 따른다
select * from employees;
SELECT * FROM departments;

-- 특정 컬럼만 선별적으로 projection
-- 사원의 이름, 입사일, 급여 출력
select first_name, hire_date, salary from employees;

-- 산술 연산 : 기본적인 산술연산 가능
-- dual : oracle 의 pseudo 테이블
-- 특정 테이블에 속한 데이터가 아닌
-- 오라클 시스템에서 값을 구한다.
select 10 * 10 * 3.14159 from dual; -- 결과 1개
select 10 * 10 * 3.14159 from employees; -- 결과는 테이블의 레코드 수

select first_name, phone_number,hire_date from employees;

select first_name, job_id * 12 from employees; -- 수치데이터 아니면 산술연산 오류

select first_name + ' ' + last_name from employees; -- 문자열은 산술 연산이 불가능하다.

-- 문자열 연결은 ||로 연결

select first_name || ' ' || last_name from employees; 
    
    
-- NVL 활용
 select first_name || ' ' || last_name as FullName,
    hire_date,
    phone_number,
    salary,
    NVL(commission_pct,0) * salary as 추가수당,
    (salary + salary*NVL(commission_pct,0)) * 12 연봉 -- commision_pct가 null이면 0으로 지정
from employees;

-- ALIAS 별칭
SELECT 
    first_name || ' ' || last_name as "FULL NAME",
    phone_number 전화번호,
    salary " 급 여 " -- 공백, 특수문자가 포함된 별칭은 ""를 붙인다.
FROM employees;

-- 연습
SELECT
    first_name || ' ' || last_name 이름,
    hire_date 입사일,
    phone_number 전화번호,
    salary 급여,
    salary*12 연봉
from employees;

select 
    first_name,
    salary,
    nvl(commission_pct,0) "commission%",
    salary+salary*NVL(commission_pct,0) extra_commission
from employees;

-- WHERE

-- 비교 연산 
-- 급여가 15000 이상인 사원

select first_name,salary 
from employees 
where salary>=15000;

-- 날짜도 비교 연산 가능
-- 입사일이 07/01/01 이후인 사원의 목록
select first_name,hire_date 
from employees
where hire_date>='07/01/01';

-- 이름이 Lex인 사원의 이름, 급여, 입사일 출력
select first_name,salary,hire_date
from employees
where first_name = 'Lex';

-- 논리 연산자
-- 급여가 10000 이하 이거나 17000 이상인 사원의 목록
select first_name,salary 
from employees
where salary<= 10000 or salary>=17000;

-- 급여가 14000 이상, 17000이하인 사원의 목록
-- between 쿼리로도 작성 가능(가독성 향상)
select first_name,salary 
from employees
where salary between 14000 and 17000;

--select first_name, salary
--from employees
--where salary between (14000,17000);

-- 널 체크
-- = null, != null은 하면 안됨
-- IS NULL, IS NOT NULL 사용.
-- 커미션을 받지 않는 사원의 목록

select first_name, NVL(commission_pct, 0) 커미션
from employees
where commission_pct is null;

-- 연습문제:
-- 담당 매니저가 없고 커미션을 받지 않는 사원의 목록

select * 
from employees 
where manager_id is null 
and commission_pct is null;


-- 비교 연산자 연습
select first_name ||' ' ||last_name name, salary 
from employees
where salary>=15000;

select first_name ||' ' ||last_name name, hire_date
from employees
where hire_date>='07/01/01';

select salary,hire_date,department_id
from employees
where first_name = 'Lex';

select * 
from employees
where department_id = '10';



-- 집합 연산자 : IN
-- 부서번호가 10,20,30 인 사원의 목록

select first_name, department_id
from employees
where department_id in ('10','20','30');

-- any
select first_name, department_id
from employees
where department_id = ANY('10','20','30');

-- all 뒤에 나오는 집합 전체 만족

select first_name, salary
from employees
where salary > ALL(14000,17000); -- 이것 보다는 동적으로 생성된 데이터를 가지고 하는 연산이 많다.

-- LIKE 부분 검색
-- % : 0글자 이상의 정해지지 않은 문자"열"
-- _ : 1글자의 정해지지 않은 문자
-- 이름에 am을 포함한 사원의 이름과 급여

select first_name, salary
from employees
where first_name like '%am%';

-- 연습: 
-- 이름의 두번째 글자가 a인 사원의 이름과 연봉
select first_name, salary
from employees
where first_name like'_a%';










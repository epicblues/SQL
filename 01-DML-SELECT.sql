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






-- ORDER BY 정렬
-- 오름차순 : 작은값 -> 큰 값 기본값
-- 내림차순 : 큰 값 -> 작은 값.
select department_id, salary,first_name
from employees
order by department_id asc;

select first_name
from employees
where salary>=10000
order by salary desc;

select department_id, salary, first_name
from employees
order by department_id,salary desc;

-----------
-- 단일행 함수
-----------

-- 한 개의 레코드를 입력으로 받는 함수
-- 문자열 단일행 함수 연습
select first_name, last_name
from employees;

select 
    first_name,last_name,
    concat(first_name,concat(' ',last_name)) 연결,
    INITCAP(first_name || ' ' || last_name), -- 각 단어의 첫글자만 대문자
    LOWER(first_name), -- 모두 소문자
    upper(first_Name), -- 모두 대문자
    LPAD(first_name,10,'*'),
    rpad(first_name,10,'*') -- 오른쪽 채우기
from employees;

select ltrim('         abc'),rtrim('abc            '), trim('*' from '*****db****'),
substr('Oracle Database', 1,4), -- 부분 문자열
substr('oracle database', 1,8)
from dual;

-- 수치형 단일행 함수
select abs(-3.14), -- 절대값
    ceil(3.14), -- 올림
    floor(3.14), -- 소수점 버림(바닥)
    mod(7,3), -- 나머지
    POWER(2,4), -- 제곱: 2의 4제곱
    ROUND(3.5), -- 소수점 반올림
    ROUND(3.14159, 3), -- 소수점 3자리까지 반올림으로 표현
    TRUNC(3.5), -- 소수점 버리기
    TRUNC(3.14159,3), -- 소수점 3자리까지 버림으로 표현
    SIGN(-10) -- 부호 함수
from dual;

--------
-- Date Format
--------

-- 현재 날짜와 시간

SELECT SYSDATE FROM DUAL; -- 1행
SELECT SYSDATE FROM EMPLOYEES; --employees의 레코드 개수 만큼

-- 날짜 관련 단일행 함수
select sysdate,
    add_months(sysdate,2), -- 2개월 후
    last_day(sysdate), -- 이번 달의 마지막 날
    round(months_between(sysdate,'99/12/31')), -- 1999년 마지막 날 이후 몇 달이 지났나
    next_day(sysdate,5), 
    round(sysdate,'MONTH'),
    trunc(sysdate,'MONTH'),
    round(sysdate,'year'),
    trunc(sysdate,'year')
from dual;
    
select first_name, to_char(salary*12, '$999,999.99') "SAL"
from employees
where department_id = 110;

------
-- 변환 함수
------

-- TO_NUMBER(s, fmt) : 문자열을 포맷에 맞게 수치형으로 변환
-- TO_DATE(s, fmt) : 문자열을 포맷에 맞게 날짜형으로 변환.
-- TO_CHAR(o, fmt) : 숫자 or 날짜를 포맷에 맞게 문자형으로 변환.

-- TO_CHAR
select first_name,hire_date ,
    TO_char(hire_date, 'YYYY-MM-DD HH24:MI:SS'),
    to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')
from employees;

select to_char(3000000,'L9,999,999')
    from dual;
    
select first_name, to_char(salary * 12, '$999,999.00') SAL
from employees;

-- TO_NUMBER 문자형을 숫자형으로
select to_number('2021'),
    to_number('$1,450.13','$999,999.99')
from dual;

-- TO_date 문자형을 날자형으로

select to_date('1999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
from dual;

-- 날짜 연산
-- Date +(-) number : 날짜에 일수 더하기, 빼기
-- date - date : 두 date사이의 일수
-- date +(-) Number / 24 : 날짜에 시간 더하기

select to_char(sysdate, 'YYYY/MM/DD HH24:MI'),
    sysdate + 1, -- 1일 뒤
    sysdate - 1, -- 1일 전
    sysdate - to_date('19991231'),
    to_char(sysdate + 13/24,'YY/MM/DD HH24:MI') -- 13시간 후
    from dual;

-----------------------
-- NULL 관련
-----------------------


-- NVL
select first_name,
    salary,
    commission_pct,
    salary + salary*nvl(commission_pct,0) 커미션
from employees;

--NVL2 함수
select first_name,
    salary,
    commission_pct,
    nvl2(commission_pct, salary*commission_pct, 0) commission
from employees;

-- CASE 함수
-- AD 관련 직원에게는 20%, SA 관련 직원에게는 10%
-- IT 관련 직원에게는 8%, 나머지는 5%

select first_name, job_id, 
    case substr(job_id, 1,2)
    when 'AD' then salary * 0.2
    when 'SA' then salary * 0.1
    when 'IT' then salary * 0.08
    else salary*0.05 end as "추가 임금"
from employees;

-- decode함수
select first_name, job_id,
    decode(substr((job_id),1,2), 'AD', salary*0.2,
        'SA', salary*0.1,
        'IT', salary*0.08,
        salary*0.05) as "추가 임금"
from employees;

-- [연습문제]
select first_name, department_id, 
    case   when department_id between 10 and 30 then 'A-GROUP'
     when  department_id  between  40 and 50 then 'B-GROUP'
    when  department_id  between  60 and 100 then 'C-GROUP'
     else   'D-GROUP' end
from employees;




    




    






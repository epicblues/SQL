-- 문제 1
select count(manager_id) haveMngCnt
from employees;


-- 문제 2

select MAX(salary) 최고임금, MIN(salary) 최저임금, MAX(salary) - MIN(salary) "최고임금 - 최저임금"
from employees;

-- 문제 3

select to_char(max(hire_date),'YYYY"년" MM"월" DD"일"') "신입사원 들어온 날" 
from employees;

-- 문제 4

select department_id 부서아이디,FLOOR(AVG(salary)) 평균임금  ,MIN(salary) 최고임금, MAX(salary) 최저임금
from employees
group by department_id;

-- 문제 5

select 
    job_id 업무아이디,
    AVG(salary),
    MIN(salary),
    MAX(salary)
from 
    employees
GROUP BY 
    job_id
ORDER BY
    MIN(salary) DESC,
    AVG(salary);
    
-- 문제 6
select 
     to_char(MIN(hire_date), 'YYYY-MM-DD DY"요일"') 입사일
from employees;
    
-- 문제 7
select 
    department_id 부서,
    round(avg(salary)) 평균임금,
    round(min(salary)) 최저임금,
    round(avg(salary) - min(salary)) "평균임금 - 최저임금"
from
    employees
group by
    department_id
having
    avg(salary) - min(salary) < 2000
order by
    round(avg(salary) - min(salary)) desc;
    
-- 문제 8

SELECT
    job_id,
    ROUND(MAX(salary)) - ROUND(MIN(salary)) 차이
from employees
GROUP BY job_id
ORDER BY 차이 desc;
    
-- 문제 9

SELECT
    manager_id 관리자_ID,
    round(avg(salary)) 평균급여,
    min(salary) 최소급여,
    max(salary) 최대급여
from 
    employees
where
    hire_date >= '05/01/01' 
group by manager_id
having avg(salary)>=5000
order by avg(salary) desc;

-- 문제 10

SELECT 
CASE WHEN hire_date <'02/12/31' THEN '창립멤버'
WHEN hire_date <'03/12/31' THEN '03년 입사'
WHEN hire_date <'04/12/31' THEN '04년 입사'
ELSE '상장이후입사' END optDate
,hire_date
FROM employees
order by hire_date;

    
    
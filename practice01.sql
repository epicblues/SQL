-- 문제 1
select first_name || ' ' || last_name as 이름,
    salary 월급,
    phone_number 전화번호,
    hire_date 입사일
from employees
order by hire_date;

-- 문제 2
select job_title, max_salary
from jobs
order by max_salary desc;

-- 문제 3

select first_name, manager_id, commission_pct, salary 
from employees
where commission_pct is null and salary>3000;

-- 문제 4

select job_title, max_salary 
from jobs
order by max_salary desc;

-- 문제 5

select first_name, salary, nvl(commission_pct,0)
from employees
order by salary desc;

-- 문제 6

select first_name,
salary,
to_char(hire_date,'YYYY-MM'),
department_id
from employees
where department_id in (10,90,100);

-- 문제 7

select first_name, salary 
from employees
where UPPER(first_name) like '%S%';

-- 문제 8

select * from departments
order by length(department_name) desc;

-- 문제 9

select UPPER(country_name) from countries
    where region_id is not null
    order by country_name;
    
-- 문제 10

select first_name,salary, replace(phone_number,'.','-'), hire_date
from employees
where hire_date < '03/12/31';
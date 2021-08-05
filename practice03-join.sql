-- [문제1]
SELECT employee_id 사번, first_name 이름, last_name 성, department_name 부서명 
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id
ORDER BY department_name,employee_id DESC;

--[문제2]
--
--SELECT employee_id, first_name, salary, department_name, job_title
--FROM 
--(SELECT * FROM employees emp JOIN departments dept
--ON emp.department_id = dept.department_id) e, jobs
--WHERE e.job_id = jobs.job_id;

SELECT employee_id 사번, first_name 이름, salary 급여, department_name 부서명, job_title 업무명
FROM 
employees emp,departments dept , jobs
WHERE emp.department_id = dept.department_id
 and emp.job_id = jobs.job_id;


-- [문제 2 - 1]
SELECT employee_id 사번, first_name 이름, salary 급여, department_name 부서명, job_title 업무명
FROM 
employees emp LEFT OUTER JOIN departments dept
ON emp.department_id = dept.department_id , jobs j
WHERE emp.job_id = j.job_id;


-- 문제 3
SELECT dept.location_id, city, department_name, department_id
FROM departments dept LEFT JOIN locations loc
                    ON  dept.location_id = loc.location_id
ORDER BY department_id;

-- 문제 3 -1
SELECT dept.location_id, city, department_name, department_id
FROM departments dept RIGHT JOIN locations loc
                    ON  dept.location_id = loc.location_id
ORDER BY department_id;

-- 문제 4
SELECT region_name,coun.country_name
FROM countries coun JOIN regions reg
ON coun.region_id = reg.region_id
ORDER BY region_name asc, coun.country_id desc;

-- 문제 5
SELECT emp.employee_id, emp.first_name, emp.hire_date, man.first_name MAN_NAME, man.hire_date MAN_HIRE_DATE
FROM employees emp JOIN employees man
ON  emp.manager_id = man.employee_id
WHERE emp.hire_date < man.hire_date;

-- 문제 6
select countries.country_name, countries.country_id,locations.location_id,city, department_name, department_id
FROM departments, locations,countries
WHERE departments.location_id = locations.location_id and locations.country_id = countries.country_id
ORDER BY country_name;

-- 문제 7

select employees.employee_id, first_name || ' ' || last_name "이름(풀네임)", job_history.job_id, start_date, end_date
from employees 
join job_history
on employees.employee_id = job_history.employee_id
where job_history.job_id = 'AC_ACCOUNT';

-- 문제 8
select
    departments.department_id,
    departments.department_name,
    departments.manager_id,
    city,
    countries.country_name,
    region_name
from 
    departments, employees, locations, countries, regions
where departments.manager_id = employee_id
    and departments.location_id = locations.location_id
    and locations.country_id = countries.country_id
    and countries.region_id = regions.region_id;
    
-- 문제 9
select
    emp.employee_id 사번,
    emp.first_name 이름,
    department_name 부서명,
    man.first_name "매니저 이름"
from
    (employees emp join employees man on emp.manager_id = man.employee_id)
    left join departments
    on emp.department_id = departments.department_id;

select
    emp.employee_id 사번,
    emp.first_name 이름,
    department_name 부서명,
    man.first_name "매니저 이름"
from
    employees emp join employees man 
    on emp.manager_id = man.employee_id
    left join departments
    on emp.department_id = departments.department_id;
    

    





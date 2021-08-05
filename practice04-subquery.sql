-- 문제 1

SELECT count(salary) from employees
where salary < (SELECT AVG(salary) from employees);

-- 문제 2
select employee_id 사원번호, first_name 이름, salary 급여, avgMax.av 평균급여, avgMax.ma 최대급여
from employees, (select avg(salary) av,max(salary) ma from employees) avgMax
where salary >= avgMax.av
order by 급여;



-- 문제 3
-- 직원 중  Steven King이 소속된 부서의 LOCATION_ID


SELECT locations.* from 
(SELECT location_id from employees join departments 
on employees.department_id = departments.department_id
where first_name = 'Steven' and last_name = 'King') king, locations
where king.location_id = locations.location_id;

--문제4
-- job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로
--출력하세요 -ANY연산자 사용
SELECT employee_id, first_name, salary 
from employees e
where salary < any(SELECT salary from employees where job_id = 'ST_MAN')
ORDER BY salary desc;

--문제5.
--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여
--(salary) 부서번호(department_id)를 조회하세요
--단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.
--조건절비교, 테이블조인 2가지 방법으로 작성하세요

SELECT department_id,MAX(salary) from employees group by department_id;
-- 조건절 비교
SELECT employee_id, first_name, salary, department_id from employees
where (department_id, salary) in
(SELECT department_id,MAX(salary) from employees group by department_id)
ORDER BY salary desc;

-- 테이블 조인
SELECT emp.employee_id, emp.first_name, salary, emp.department_id 
from employees emp, 
(SELECT department_id,MAX(salary) maxsal from employees group by department_id) groupMax
where emp.department_id = groupMax.department_id and emp.salary = groupMax.maxsal
order by salary desc;

-- 문제 6
SELECT job_title, maxSal 최고연봉 from 
jobs,(SELECT job_id, MAX(salary) maxSal from employees group by job_id) maxJob
where jobs.job_id = maxjob.job_id
ORDER BY maxSal desc;

-- 문제7.
--자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름
--(first_name)과 급여(salary)을 조회하세요
SELECT employee_id, first_name, salary from employees e
where salary > (SELECT avg(salary) from employees where e.department_id = department_id);

-- 문제8.
-- 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력
--하세요
SELECT *
from (select RANK() OVER (ORDER BY hire_date asc) as RN,employee_id, first_name, salary, hire_date from employees)
where RN<= 15 and RN >=11;
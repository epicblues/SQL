-- 문제 1

SELECT count(salary) from employees
where salary < (SELECT AVG(salary) from employees);

-- 문제 2
select employee_id 사원번호, first_name 이름, salary 급여, avgMax.av 평균급여, avgMax.ma 최대급여
from employees, (select avg(salary) av,max(salary) ma from employees) avgMax
where salary >= avgMax.av
order by 급여;

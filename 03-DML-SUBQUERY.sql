-----------
-- SUBQUERY
-----------

-- 하나의 질의문 안에 다른 질의문을 포함하는 형태
-- 전체 사원 중, 급여의 중앙값보다 많이 받는 사원

SELECT first_name from employees
WHERE salary > (SELECT MEDIAN(SALARY) from EMPLOYEES); 

-- Den 보다 늦게 입사한 사원들
-- 1. Den 입사일 쿼리
-- 2. 특정 날짜 이후 입사한 사원 쿼리
-- 3. 두 쿼리를 합틴다.

SELECT * from employees
where hire_date >= (select hire_date from employees where first_name = 'Den');

-- 다중행 서브쿼리
-- 서브 쿼리의 결과 레코드가 둘 이상이 나올 때는 단일행 연산자를 사용할 수 없다.
-- IN, ANY, ALL, EXISTS 등의 집합 연산자를 활용. 
SELECT salary FROM employees WHERE department_id = 110;

-- ALL(AND) 
-- salary >12008 OR salary >8300
SELECT first_name, salary from employees 
WHERE salary > ALL
(SELECT salary FROM employees WHERE department_id = 110);

-- ANY(OR) 
-- salary >12008 OR salary >8300
SELECT first_name, salary from employees 
WHERE salary > ANY
(SELECT salary FROM employees WHERE department_id = 110);

-- 각 부서별로 최고 급여를 받는 사원을 출력해봅시다.
-- 서브 쿼리의 column 수 만큼 where 비교 에도 column 수를 맞춰야 한다.
SELECT department_id,employee_id, first_name, salary from employees where (department_id, salary) in
(SELECT department_id, max(salary) from employees group by department_id)
ORDER BY department_id; 

-- 서브쿼리와 JOIN

SELECT e.department_id, e.employee_id, e.first_name, e.salary 
from employees e, (SELECT department_id, max(salary) salary from employees group by department_id) sel
WHERE e.department_id = sel.department_id and e.salary = sel.salary;
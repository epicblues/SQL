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

-- Correlated Query
-- 외부 쿼리와 내부 쿼리가 연관 관계를 맺는 쿼리

SELECT e.department_id, e.employee_id, e.first_name,e.salary
FROM employees e
WHERE e.salary = (SELECT MAX(salary) FROM employees
                    WHERE department_id = e.department_id)
ORDER BY e.department_id;        

-- TOP - K Query
-- ROWNUM : 레코드의 순서를 가리키는 가상의 컬럼(Pseudo Column)

--2007년 입사자 중에서 급여 순위 5위

SELECT ROWNUM, first_name  FROM 
(SELECT * from employees where hire_date LIKE '07%' ORDER BY salary desc)
WHERE ROWNUM <= 5;

-- 집합 연산 : SET
-- UNION : 합집합, UNION ALL : 합집합, 중복 요소 체크 안함
-- INTERSECT : 교집합
-- MINUS : 차집합

-- 05/01/01 이전 입사자 쿼리
SELECT first_name, salary, hire_date       -- 24
from employees where hire_date < '05/01/01'; 
-- 급여를 12000 수령 사원.
SELECT first_name, salary, hire_date       -- 8
from employees where salary >12000;

SELECT first_name, salary, hire_date      
from employees where hire_date < '05/01/01'
UNION -- 합집합
SELECT first_name, salary, hire_date       
from employees where salary >12000;

SELECT first_name, salary, hire_date      
from employees where hire_date < '05/01/01'
UNION ALL-- 합집합(중복 허용)
SELECT first_name, salary, hire_date       
from employees where salary >12000;

SELECT first_name, salary, hire_date      
from employees where hire_date < '05/01/01'
INTERSECT-- AND
SELECT first_name, salary, hire_date       
from employees where salary >12000;

SELECT first_name, salary, hire_date      
from employees where hire_date < '05/01/01'
MINUS-- 차집합
SELECT first_name, salary, hire_date       
from employees where salary >12000;

-- 순위 함수
-- RANK() : 중복 순위가 있으면 건너뛴다.
-- DENSE_RANK() 중복 순위 상관 없이 다음 순위
-- ROW_NUMBER() 중복 순위 상관 없이 차례대로

SELECT salary, first_name, 
    RANK() over (ORDER BY salary DESC) rank,
    DENSE_RANK() over (ORDER BY salary DESC) dense_rank,
    ROW_NUMBER() over (ORDER BY salary DESC) row_number,
    ROWNUM
from employees;

-- Hierarchical Query (Oracle)
-- TREE 형태의 구조 추출
-- LEVEL 가상 컬럼

SELECT level,employee_id, first_name, manager_id
FROM employees
START WITH manager_id is null -- 트리 시작 조건
CONNECT BY PRIOR employee_id = manager_id
ORDER BY level;
















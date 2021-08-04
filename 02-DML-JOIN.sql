-- 먼저 employees와 departments를 확인

desc employees;
DESC departments;

-- 두 테이블로부터 모든 레코드를 추출 : cartisan project

SELECT first_name, department_name
FROM employees, departments
ORDER BY first_name;

-- 테이블 조인을 위한 조건을 부여할 수 있다.
select first_name, emp.department_id, dept.department_id, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id;

-- 총 몇 명의 사원이 있는가
select count(*) from employees; -- 107명

select first_name, emp.department_id, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id; -- 106명

-- department_id가 null인 사원?
select * from employees 
where department_id is null;


-- USING : 조인할 컬럼을 명시
SELECT first_name, department_name 
FROM employees JOIN departments USING(department_id);

-- ON : join의 조건절
SELECT first_name, department_name
FROM employees emp JOIN departments dept
                    ON emp.department_id = dept.department_id; -- JOIN의 조건
                    
-- Natural Join 
-- 조건 명시 하지 않고, 같은 이름을 가진 column으로 join을 수행한다.
SELECT first_name, department_name
FROM employees NATURAL JOIN departments;
-- 관계 없는 manager_id도 같은 이름이라 생각하고 참조해서 위의 결과들과 다르다.
-- emp.manager_id = dept.manager_id AND emp.department_id = dept.department_id

-- Theta join
-- Join 조건이 = 이 아닌 것

--------------
-- OUTER JOIN 
--------------

--조건이 만족하는 짝이 없는 튜플도 NULL을 포함해서 결과를 출력한다.
--모든 레코드를 출력한 테이블의 위치를 따라 LEFT, RIGHT, FULL OUTER JOIN으로 구분
--ORACLE의 경우 NULL을 출력한 조건 쪽에 (+)를 붙인다.

SELECT first_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

-- 
SELECT first_name, e.department_id, d.department_id, department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

-- RIGHT OUTER JOIN : 짝이 없는 오른쪽 레코드도 null을 포함하여 출력
-- ANSI SQL
SELECT first_name, e.department_id, d.department_id, department_name
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;
-- ORACLE SQL
SELECT first_name, e.department_id, d.department_id, department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;

-- FULL OUTER JOIN : 양쪽 테이블 레코드 전부를 짝이 없어도 출력을 시킨다.
-- ORACLE SQL로는 불가능
--SELECT first_name, e.department_id, d.department_id, department_name
--FROM employees e, departments d
--WHERE e.department_id(+) = d.department_id(+);

-- ANSI SQL
SELECT first_name, e.department_id, d.department_id, department_name
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id;


---------------------
-- SELF JOIN --
---------------------
-- 자기 자신과 JOIN
-- 자기 자신을 두 번 이상 호출 -> alias를 사용할 수 밖에 없는 JOIN
select * from employees; --> 107명

-- 사원 정보, 매니저 이름을 함께 출력
-- 방법 1
SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
from employees emp JOIN employees man
                    ON emp.manager_id = man.employee_id
                    ORDER BY emp.employee_id;

-- 방법 2

SELECT emp.employee_id,emp.first_name,man.employee_id manager_id,man.first_name manager_name
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id
ORDER BY emp.employee_id;

-- 방법 3 OUTER JOIN(manager가 없는 사람 포함)

SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
from employees emp LEFT OUTER JOIN employees man
                    ON emp.manager_id = man.employee_id
                    ORDER BY emp.employee_id;

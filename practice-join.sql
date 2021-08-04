-- [문제1]
SELECT employee_id, first_name, last_name, department_name 
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id
ORDER BY department_name,employee_id DESC;

--[문제2]

SELECT employee_id, first_name, salary, department_name, job_title
FROM 
(SELECT * FROM employees emp JOIN departments dept
ON emp.department_id = dept.department_id) e, jobs
WHERE e.job_id = jobs.job_id;

-- [문제 2 - 1]
SELECT employee_id, first_name, salary, department_name, job_title
FROM 
(SELECT * FROM employees emp LEFT JOIN departments dept
ON emp.department_id = dept.department_id) e, jobs
WHERE e.job_id = jobs.job_id;

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
FROM countries coun LEFT JOIN regions reg
ON coun.region_id = reg.region_id
ORDER BY region_name asc, coun.country_id desc;

-- 문제 5
SELECT emp.employee_id, emp.first_name, emp.hire_date, man.first_name MAN_NAME, man.hire_date MAN_HIRE_DATE
FROM employees emp INNER JOIN employees man
ON  emp.manager_id = man.employee_id
WHERE emp.hire_date < man.hire_date;

-- 문제 6
SELECT country_name,coun.country_id, city, depCon.location_id,department_name,department_id
FROM 
(SELECT * FROM departments 
INNER JOIN locations 
ON departments.location_id = locations.location_id) depCon 
LEFT JOIN countries
ON depCon.country_id = countries.country_id
ORDER BY country_name;

SELECT * FROM departments 
INNER JOIN locations 
ON departments.location_id = locations.location_id






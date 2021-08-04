-----------
-- 집계 함수
-----------

-- 여러 레코드로부터 데이터를 수집, 하나의 결과 행을 반환

-- count : 갯수 세기
SELECT count(*) from employees; -- 특정 컬럼이 아닌 레코드의 갯수를 센다.

SELECT count(commission_pct) FROM employees; -- 해당 컬럼이 null이 아닌 갯수.
SELECT count(*) FROM employees where commission_pct is not null; -- 위 명령문과 같은 의미.

-- sum : 합계
-- 급여의 합계
SELECT sum(salary) from employees;

-- avg: 평균
-- 급여의 평균
SELECT avg(salary) from employees;

-- avg 함수는 null값을 집계에서 제외한다.

-- 사원들이 받는 평균 커미션 비율
SELECT avg(NVL(commission_pct,0)) from employees;

-- min/max: 최소값, 최대값
SELECT min(salary),MAX(salary), avg(salary), median(salary) 
from employees;

-- 일반적 오류
SELECT department_id, AVG(salary)
from employees; -- ERROR

-- 수정
SELect department_id, ROUND(AVG(salary))
from employees
GROUP BY department_id
ORDER BY department_id;


-- 집계 함수에 참여한 SELECT 문의 칼럼 목록에는
-- Group BY에 참여한 필드, 집계 함수만 올 수 있다.

-- 부서별 평균 급여
-- 평균 급여 > 7000
-- 집계 함수 실행 이전에 WHERE 절을 검사하기 때문에
-- 집계 함수는 WHERE 절에서 사용할 수 없다.

-- 집계 함수 실행 이후에 조건 검사하려면 
-- HAVING 절을 이용

select department_id, round(avg(nvl(salary,0))) average
from employees
group by department_id
having average > 7000
ORDER BY department_id;


select department_id, count(*), sum(salary)
from employees
GROUP by department_id
HAVING sum(salary)>20000
ORDER BY department_id;

----------
-- 분석 함수
----------

-- ROLLUP
-- 그룹핑된 결과에 대한 상세 요약을 제공하는 기능
-- 일종의 ITEM Total

SELECT department_id, 
    job_id,
    SUM(salary)
from employees
GROUP BY ROLLUP(department_id,job_id);

-- CUBE 함수
-- Cross Table 에 대한 SUMMARY를 함께 추출
-- ROLLUP 함수에서 추출되는 ITEM TOTAL과 함께
-- Column Total 값을 함께 추출

SELECT department_id, 
    job_id,
    SUM(salary)
from employees
GROUP BY CUBE(department_id,job_id)
ORDER BY department_id;

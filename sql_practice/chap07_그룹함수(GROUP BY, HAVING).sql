-- 집계함수 AVG, MAX, MIN, SUM, COUNT
-- 여러 행을 묶어서 한 번에 함수를 적용
-- 그룹화를 따로 하지 않으면 그룹은 테이블 전체가 됩니다.

SELECT
AVG(salary) AS 급여평균,
MAX(salary),
sum(salary),
count(salary)
FROM employees
;

SELECT COUNT(*) FROM employees;
SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(manager_id) FROM employees;

-- 그룹 함수는 단독적으로 사용할 때는 테이블 전체가 그룹의 대상이 되지만
-- 일반 컬럼과 동시에 출력할 수 없다. 일반 컬럼을 반드시 그룹화해야 한다.

SELECT
department_id,
AVG(salary),
COUNT(*)
FROM employees
GROUP BY department_id
;

SELECT
department_id,
AVG(salary),
COUNT(*)
FROM employees      -- 에러 발생
;

-- GROUP BY절을 사용할 때 GROUP절에 묶이지 않은 컬럼은 출력할 수 없다.
SELECT
job_id,                 -- 한 부서에 job_id가 여러 개일 수 있기 때문에 에러 발생
department_id,
AVG(salary),
COUNT(*)
FROM employees
GROUP BY department_id
;

-- GROUP BY 절을 2개 이상 사용하면 컬럼을 여러개 출력 가능
SELECT
job_id,                
department_id,
AVG(salary),
COUNT(*)
FROM employees
GROUP BY department_id, job_id
;

-- GROUP BY를 통해 그룹화 할 때, 조건을 지정할 경우 HAVING을 사용
-- WHERE은 일반 조건절. GROUP BY보다 먼저 수행됨.
SELECT
department_id,
SUM(salary),
AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000
;

-- 부서 아이디가 50이상인 사람들을 그룹화하고, 그룹 급여 평균이 5000이상만 출력
SELECT
department_id,
AVG(salary)  AS 평균급여
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC
;

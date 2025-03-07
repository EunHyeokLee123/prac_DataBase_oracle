
SELECT
    department_id, job_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id
;

-- ROLLUP(arg1, arg2) -> arg1과 arg2로 그룹화. -> 각 그룹별 SUM(salary)
-- -> arg1 그룹의 SUM(salary) -> 마지막에는 전체 SUM(salary)
-- 특정 컬럼들의 단계적 합계를 계산.
-- 부서별 급여 합계
-- 부서와 직무 조합별 급여 합계
-- 전체 급여 합계

SELECT
    department_id, job_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY ROLLUP (department_id, job_id)
ORDER BY department_id
;

-- CUBE(arg1, arg2): 모든 가능한 조합을 고려하여 집계.
-- 직무별 급여 합계
-- 부서별 급여 합계
-- 부서와 직무 조합별 급여 합계
-- 전체 급여 합계

SELECT
    department_id, 
    job_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY CUBE (department_id, job_id)
-- ORDER BY department_id
;

-- GROUPING SETS(arg1, arg2): 주어진 그룹 집합에 대해서만 집계
-- 직무별 급여 합계
-- 부서별 급여 합계

SELECT
    department_id, 
    job_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY GROUPING SETS (department_id, job_id)
ORDER BY department_id
;

SELECT
    CASE GROUPING(department_id) WHEN 1 THEN 0  -- NULL로 작성되는 컬럼을 없애기 위해
    ELSE department_id END AS dept_id,              -- NULL 대신 9999를 입력
    job_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY CUBE (department_id, job_id)
-- ORDER BY department_id
;



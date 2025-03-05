SELECT 
*
FROM employees
WHERE hire_date = '04/01/30';

-- 데이터의 행 제한(BETWEEN, IN, LIKE)

SELECT *
FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31'
;

-- IN => 특정 값들과 비교할 때 사용

SELECT 
*
FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP')
;


-- LIKE 연산자 (지정 문자열 포함 여부)

SELECT
first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '03%'
;

SELECT
first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%03'
;

SELECT
first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%'
;

SELECT
first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%___05___%'
;

SELECT *
FROM employees
WHERE commission_pct IS NOT NULL
;

SELECT
* 
FROM
employees
WHERE (job_id = 'IT_PROG' OR job_id = 'FI_MGR')
AND salary >= 6000
;

-- 데이터 정렬 (SELECT 구문의 가장 마지막에 배치됨.)
-- ASC : 오름차순, 작은값부터 큰값
-- DESC : 내림차순, 큰값부터 작은값

SELECT 
*
FROM employees
where job_id = 'IT_PROG'
ORDER BY first_name DESC
;

SELECT
first_name,
salary*12 AS pay
FROM employees
ORDER BY pay DESC
;








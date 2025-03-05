-- 오라클 주석

/* 
 여러줄 주석
*/

SELECT * FROM EMPLOYEES;

SELECT 
FIRST_NAME, 
LAST_NAME 
FROM 
EMPLOYEES;
-- 컬럼을 조회하는 위치에서 산술 연산이 가능함.

SELECT
employee_id,
first_name,
last_name,
salary,
salary+salary*0.1 AS 성과금
FROM employees;

SELECT
first_name AS 성, 
last_name AS 이름,
salary AS 급여
FROM employees;

SELECT
department_id,
commission_pct
FROM employees;

/*
오라클은 홑따옴표로 문자를 표현하고, 문자열 안에 홑따옴표 특수기호를
표현하고 싶다면 ''를 두 번 연속으로 쓰시면 됩니다.
문자열 연결기호는 || 입니다. 문자열의 덧셈 연산을 허용하지 않습니다.
*/

SELECT 
first_name || ' ' || last_name
FROM employees;

SELECT DISTINCT
department_id
FROM employees;




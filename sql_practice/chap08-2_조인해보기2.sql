SELECT
first_name,
e.department_id,
department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id 
WHERE e.department_id = 50
;

SELECT
first_name,
e.department_id,
department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id 
;

SELECT
first_name,
e.department_id,
department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id 
;

-- 풀 아우터 조인
-- LEFT + RIGHT 조인
SELECT
first_name,
e.department_id,
department_name
FROM employees e FULL JOIN departments d
ON e.department_id = d.department_id 
;

-- CROSS JOIN
-- 단순히 모든 컬럼에 대한 JOIN을 수행
-- 실제로는 거의 사용하지 않음.
-- 실행 결과의 컬럼 수는 각 컬럼의 수끼리의 곱과 같다

SELECT
COUNT(*) -- 107 * 27
FROM employees
CROSS JOIN departments;

-- 오라클 문법으로 CROSS JOIN
SELECT COUNT(*) FROM employees, departments;

-- 여러 개 테이블 조인 -> 조인 조건에 사용할 키 값을 찾아
-- 연결해서 쓰면 된다.

SELECT
first_name,
e.department_id,
d.department_name,
loc.city
FROM employees e 
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN locations loc
ON d.location_id = loc.location_id
;

-- SELF JOIN
-- 동일 테이블 사이의 조인을 의미
-- 동일 테이블 컬럼을 통해 기존의 존재하는 값을 매칭시켜 가져올 때 사용

-- 각 사원별 매니저의 이름을 조회

SELECT
e1.employee_id,
e1.first_name,
e1.manager_id,
e2.first_name,
e2.employee_id
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
;

-- 각 매니저가 담당하는 사원의 명수

SELECT
m.employee_id AS manager_id,
m.first_name AS manager_name,
COUNT(e.employee_id)    AS 사원수
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.first_name
;

-- Natural Join
-- 동일한 이름을 갖는 컬럼들에 대해 자동으로 조인조건을 생성하는 기법입니다.
-- 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER JOIN을 수행합니다.
-- 조인되는 동일 이름의 컬럼은 타입이 같아야 하며,
-- ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안됩니다.
-- 조회하려는 컬럼에 *을 붙이면, 공통 컬럼은 한 번만 표기됩니다.

SELECT 
e.employee_id, e.first_name,
d.department_name, department_id
FROM employees e
NATURAL JOIN departments d
;

-- USING JOIN
-- NATURAL JOIN과는 다르게, USING을 사용하면 원하는 컬럼에 대해서만 선택적 조인조건을
-- 부여할 수 있습니다.
-- USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 표기하시면 안됩니다.

SELECT 
e.employee_id, e.first_name,
d.department_name, department_id
FROM employees e
JOIN departments d USING(department_id)
;













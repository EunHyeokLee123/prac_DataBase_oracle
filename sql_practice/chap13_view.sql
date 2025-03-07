/*
view는 제한적인 자료만 보기 위해 사용하는 가상 테이블의 개념입니다.
뷰는 기본 테이블로 유도된 가상 테이블이기 때문에
필요한 컬럼만 저장해 두면 관리가 용이해 집니다.
뷰는 가상테이블로 실제 데이터가 물리적으로 저장된 형태는 아닙니다.
뷰를 통해서 데이터에 접근하면 원본 데이터는 안전하게 보호될 수 있습니다.
*/

SELECT * FROM user_sys_privs;

-- 단순 뷰 : 하나의 테이블을 이용해서 생성한 뷰
-- 뷰의 컬럼명은 함수 호출문, 연산식 등 가상 표현식이면 안됨!

SELECT 
    employee_id, 
    first_name||' '||last_name AS 풀네임,
    job_id,
    salary
FROM employees
WHERE department_id =  60
;

CREATE VIEW view_emp AS (
    SELECT 
    employee_id, 
    first_name||' '||last_name AS 풀네임,
    job_id,
    salary
FROM employees
WHERE department_id =  60
);

SELECT * FROM view_emp;


-- 복합 뷰 : 두 개 이상의 테이블을 조인해서 생성한 뷰
-- 복잡한 쿼리를 반복사용하지 않고, 빠른 조회를 위해 사용 -> 생산성 증가

CREATE VIEW view_emp_dept_job AS (
    SELECT
        e.employee_id  AS 사원ID,
        e.first_name||' '||e.last_name   AS 풀네임,
        d.department_name AS 부서명,
        j.job_title   AS 직업명
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY e.employee_id; -- 쿼리문에 넣어도 똑같음.


SELECT * FROM view_emp_dept_job;

-- 뷰의 수정 (CREATE OR REPLACE)
-- 동일 이름을 해당 구문을 사용하면 데이터가 변경되면서 새롭게 생성되고,
-- 기존에 존재하지 않았다면 새로 CREATE됨.

CREATE OR REPLACE VIEW view_emp_dept_job AS (
    SELECT
        e.employee_id  AS 사원ID,
        e.first_name||' '||e.last_name   AS 풀네임,
        d.department_name AS 부서명,
        j.job_title   AS 직업명,
        e.salary AS 급여
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY e.employee_id; -- 쿼리문에 넣어도 똑같음.


SELECT
    직업명,
    AVG(급여)   AS avg
FROM view_emp_dept_job
GROUP BY 직업명
ORDER BY avg DESC;

-- 뷰 삭제
DROP VIEW ciew_emp_dept_job;


/*
VIEW에 INSERT가 일어나는 경우 실제 테이블에도 반영이 됩니다.
그래서 VIEW의 INSERT, UPDATE, DELETE에는 많은 제약 사항이 따릅니다.
원본 테이블이 NOT NULL인 경우 VIEW에 INSERT가 불가능합니다.
VIEW에서 사용하는 컬럼이 가상열인 경우에도 안됩니다.
*/

/*
VIEW에 INSERT가 일어나는 경우 실제 테이블에도 반영이 됩니다.
그래서 VIEW의 INSERT, UPDATE, DELETE에는 많은 제약 사항이 따릅니다.
원본 테이블이 NOT NULL인 경우 VIEW에 INSERT가 불가능합니다.
VIEW에서 사용하는 컬럼이 가상열인 경우에도 안됩니다.
*/

SELECT * FROM view_emp_dept_job;

-- 가상열이 존재하기 때문에 INSERT 안됨!
INSERT INTO view_emp_dept_job
VALUES(300, 'test', 'test','test', 10000);

-- JOIN된 뷰 (복합 뷰)의 경우에는 한번에 삽입할 수 없음.
INSERT INTO view_emp_dept_job
(사원ID, 부서명, 직업명, 급여)
VALUES(300, 'test', 'test', 10000);

-- 원본 테이블의 컬럼 중 NOT NULL 컬럼이 존재하고, 그 컬럼을
-- view에서 지목할 수 없다면 INSERT가 불가능합니다.

INSERT INTO view_emp
    (employee_id, job_id, salary)
VALUES(300,'test',10000);


-- DELETE FROM view_emp_dept_job  -> 실행하면 employees의 id가 107인 데이터가 삭제됨
-- WHERE employee_id = 107;
-- 뷰에서 삭제를 진행하는 것은 옳지 못한 결과가 나올 수 있으니
-- 삭제를 원하면 원본 테이블에서 삭제하는 것이 바람직하다.

-- WITH CHECK OPTION -> 조건 제약 컬럼
-- 뷰를 생성할 때 사용한 조건 컬럼은 뷰를 통해서 변경할 수 없게 해주는 키워드

CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60   -- WHERE 조건 절에서 사용한 department 컬럼은 뷰를 통해서 변경불가능
)WITH CHECK OPTION CONSTRAINT view_emp_test_ck
;

SELECT * FROM view_emp_test;

-- 읽기전용 뷰  -> SELECT만 허용, DML 연산을 막음
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60   -- WHERE 조건 절에서 사용한 department 컬럼은 뷰를 통해서 변경불가능
)WITH READ ONLY   -- 읽기 전용 뷰 생성 조건 키워드
;























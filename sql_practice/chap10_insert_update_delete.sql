-- INSERT
-- 테이블 구조 확인

DESC departments;

-- INSERT의 첫번째 방법(모든 컬럼 데이터를 한 번에 지정해서 삽입)

--> 모든 컬럼을 지정하지 않고 값만 주는 경우에는 모든 값을 전부 줘야한다.
INSERT INTO departments
VALUES(300, '개발부', 100, 1500);

SELECT * FROM departments;

-- INSERT의 두번째 방법(직접 컬럼을 지정해서 저장, NOT NULL컬럼인지 확인!)
INSERT INTO departments
    (department_id, department_name)
VALUES
    (301, '영업부');   -- NOT NULL인 컬럼은 꼭 넣어줘야 한다!
    
ROLLBACK;

-- 사본 테이블 생성법
-- 사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복사
-- WHERE절에 false(1=2와 같은)를 주면 -> 테이블의 구조만 복사되고 데이터는 복사 X
-- 단, 제약조건은 복사되지 않는다.

CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);        --> 쿼리문 결과대로 테이블을 복제됨

SELECT * FROM emps;

CREATE TABLE emps2 AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2);   

SELECT * FROM emps2;

DROP TABLE emps2;

INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date
from employees WHERE department_id = 50);

-------------------------------------------------------------

-- UPDATE
-- UPDATE 테이블이름 SET 컬럼 = 값, 컬럼 = 값,.... WHERE 누구를 수정할지(조건문)

UPDATE emps
SET first_name = '춘식이'  -- 조건 지정 안하면 테이블 전체가 대상이 됨.
WHERE employee_id = 100
;

SELECT * FROM emps WHERE employee_id = 100;

-- 여러개 수정

UPDATE emps
SET first_name = '야옹이', job_id = '백수', hire_date = sysdate  
WHERE employee_id = 100;


ROLLBACK;


SELECT * FROm emps;

UPDATE emps
SET(job_id, hire_date) = 
    (SELECT
        job_id, hire_date
    FROM emps
    WHERE employee_id = 100)
WHERE employee_id = 101;

-----------------------------------------------------

-- DELETE
-- DELETE도 WHERE 지정하지 않으면 테이블 전체 행이 대상이 된다.

DELETE FROM emps
WHERE employee_id = 101;

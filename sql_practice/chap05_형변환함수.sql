-- 형변환 함수 TO_CHAR, TO_NUMBER, TO_DATE

-- 날짜를 문자로 TO_CHAR(값, 형식)
-- 날짜를 문자로 형 변환할 때 원하는 형식으로 날짜를 표현할 수 있습니다.
-- 날짜 포맷형식: Y - 연도, MM - 두자리 월, D - 일수 DY - 요일
-- 시간 포맷형식: HH12 - 시(1~12), HH24 (0-23), MI - 분, SS - 초

SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD DY PM HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate,'YY"년" MM"월" DD"일"') FROM dual; -- 서식문자를 제외한 문자를 넣으려면 쌍따옴표로 감싸야함.

-- 숫자를 문자로 TO_CHAR(값, 형식)

-- 형식에서 사용하는 '9'는 실제 숫자 9가 아니라 자리수를 표현하기 위한 기호
SELECT
TO_CHAR(20000, '99,999')
FROM dual;

SELECT
TO_CHAR(20000, 'L99,999')
FROM dual;

SELECT
TO_CHAR(20000.29, 'L99,999.9')
FROM dual;

SELECT
first_name,
TO_CHAR(salary,'$99,999') AS salary
FROM employees;

-- 문자를 숫자로 변환하는 TO_NUMBER(값, 형식) 

SELECT'2000'+2000 FROM dual; 

-- 자동변환
SELECT '$3,000' + 2000 FROM dual; -- 에러
-- 변환하려는 문자가 깔끔한 숫자가 아니라면, 서식문자를 통해 형식을 알려줘야함.
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual; 

-- 문자를 날짜로 TO_DATE(값, 형식)
SELECT TO_DATE('2023-04-13','YYYY-MM-DD')+1 FROM dual;
SELECT TO_DATE('2024-07-18 12:23:50','YYYY-MM-DD HH:MI:SS') FROM dual;
SELECT TO_DATE('2023년 4월 13일','YYYY"년" MM"월" DD"일"') FROM dual;

-------------------------------------------------------------

-- NULL 형태를 변환하는 함수 NVL(컬럼 혹은 값, 변환할 타겟값)

SELECT 
first_name,
NVL(commission_pct, 0) AS commission_pct
FROM employees
;

-- NULL 형태를 변환하는 함수 NVL2(컬럼 혹은 값, null이 아닌 경우, null인 경우)
-- 연산 중간에 NULL이 있으면 전체 결과가 NULL이 되니 주의!

SELECT
first_name,
salary,
commission_pct,
-- salary+(salary * NVL2(commission_pct,commission_pct, 0)) AS 총연봉
NVL2(commission_pct, salary+(salary*commission_pct), salary) AS 총연봉
from employees
;

-- COALESCE(expr1, ...)
-- 전달된 표현식 중 NULL이 아닌 값이 최초로 발견되면 그 값을 리턴

SELECT 
COALESCE(3000, NULL, NULL, 4000)
FROM dual
;

-- comm_pct가 null인 애들은 0을 적용, null이 아닌 애들은 자신의 comm_pct를 적용
SELECT
first_name,
salary,
salary + (salary * COALESCE(commission_pct, 0)) AS 급여
FROM employees
;

-- DECODE(컬럼 혹은 표현식, 항목1, 결과1, 항목2, 결과2,...,default)  
-- 오라클 전용함수, 동등 비교만 가능

SELECT
first_name,
job_id,
salary,
DECODE(job_id,
'IT_PROG', salary*1.1,
'FI_MGR', salary*1.2,
'AD_VP', salary*1.3,
0    -- default
) AS result
FROM employees
;

-- CASE문 WHEN, THEN, END
-- ANSI 표준 구문

SELECT
first_name,
job_id,
salary,
(CASE job_id
WHEN 'IT_PROG' THEN salary * 1.1
WHEN 'FI_MGR' THEN salary * 1.2
WHEN 'AD_VP' THEN salary * 1.3
ELSE 0
END
) AS result
FROM employees
;




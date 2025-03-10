-- lower(), initcap(), upper()

/*
dual이라는 테이블은 sys가 소유하는 오라클의 표준 테이블로서,
오직 한 행에 한 컬럼만 담고 있는 dummy 테이블 입니다.
일시적인 산술 연산이나 날짜 연산 등에 주로 사용합니다.
모든 사용자가 접근할 수 있습니다.
*/

SELECT
'abcdef',
LOWER('abcDEF'),
INITCAP('abcDEF'),
UPPER('abcDEF')
FROM dual;

SELECT
last_name,
LOWER(last_name),
INITCAP(last_name),
UPPER(last_name)
FROM employees;

SELECT
last_name,
salary
FROM employees
where lower(last_name) = 'austin'
;

-- length(길이), instr(문자 찾기, 없으면 0 반환, 있으면 인덱스 반환)
SELECT
'abcdef', LENGTH('abcdef'), INSTR('abcdef', 'b')
FROM dual
;

SELECT
first_name, 
LENGTH(first_name),
INSTR(first_name,'a')
FROM employees
;

-- substr(자를 문자열, 시작인덱스, 길이)
-- concat(문자, 문자) 2개의 매개문자를 이어줌.

SELECT
last_name,
SUBSTR(last_name, 1, 3),
concat(first_name, last_name)
FROM employees
;

-- LTRIM(), RTRIM()
-- TRIM() -> 양쪽 공백 제거
-- LTRIM(param1, param2) -> param2의 값을 param1에서 찾아서 제거 (왼쪽부터)
-- RTRIM(param1, param2) -> param2의 값을 param1에서 찾아서 제거 (오른쪽부터)

SELECT
'javascript',
LTRIM('javascript_java', 'java'),
RTRIM('javascript_java', 'java'),
TRIM('     java  s c r ipt    ')
FROM dual
;

-- LPAD(), RPAD() : 좌, 우측을 지정한 문자열로 채우기

SELECT
LPAD('abc', 10, '*'),
RPAD('abc', 10, '*')
FROM dual
;

-- REPLACE(str, old, new) ==> str의 old를 new로 바꿈

SELECT
REPLACE('My dream is president', 'president', 'programmer')
FROM dual
;

SELECT
REPLACE(REPLACE('My dream is president', 'president', 'programmer'),' ', '')
FROM dual
;

/*
문제 1.

EMPLOYEES 테이블에서 이름, 입사일자 컬럼으로 변경(별칭)해서 이름순으로 오름차순 출력 합니다.
조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다. (CONCAT)
조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다. (REPLACE)
*/

SELECT
-- first_name || ' ' || last_name AS 이름,
concat(first_name, last_name) AS 이름,
REPLACE(hire_date,'/','') AS 입사일자
FROM employees
ORDER BY 이름
;












SELECT * 
FROM employees;


/*
문제 2.

EMPLOYEES 테이블에서 phone_number컬럼은 ###.###.####형태로 저장되어 있다고 가정합니다.
여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 
전화 번호를 출력하도록 쿼리를 작성하세요. (CONCAT, SUBSTR 사용)
*/

SELECT
CONCAT('02', SUBSTR(PHONE_NUMBER, 4, 8))
FROM employees;


/*
문제 3. 

EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
조건 1) 비교하기 위한 값은 소문자로 비교해야 합니다.(힌트 : lower 이용)
조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
*/

SELECT
RPAD(substr(first_name,1,3),10,'*') AS name,
LPAD(salary,10,'*') AS salary
FROM employees
WHERE lower(job_id) = 'it_prog'
;








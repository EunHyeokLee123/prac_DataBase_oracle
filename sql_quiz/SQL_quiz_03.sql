SELECT * FROM employees;

SELECT * FROM employees WHERE commission_pct IS NOT NULL;


/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.
(TO_CHAR() 함수를 사용해서 연도만 변환합니다. 그리고 그것을 그룹화 합니다.)
*/

SELECT
TO_CHAR(hire_date, 'YY'),
COUNT(*)
FROM employees
GROUP BY TO_CHAR(hire_date, 'YY')
ORDER BY TO_CHAR(hire_date, 'YY')
;

/*
문제 3.
급여가 5000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
단 부서 평균 급여가 7000이상인 부서만 출력하세요.
*/

SELECT
department_id,
AVG(salary)
FROM employees
WHERE salary >= 5000
GROUP BY department_id
HAVING AVG(salary) >= 7000
;


/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절사 하세요.
*/

SELECT
department_id,
TRUNC(AVG(salary+(salary*commission_pct)), 1),
SUM(salary+(salary*commission_pct)),
COUNT(salary+(salary*commission_pct))
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id
;


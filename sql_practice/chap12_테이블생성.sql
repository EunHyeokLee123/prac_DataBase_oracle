/*
- NUMBER(2) -> 정수를 2자리까지 저장할 수 있는 숫자형 타입.
- NUMBER(5, 2) -> 정수부, 실수부를 합친 총 자리수 5자리, 소수점 2자리
- NUMBER -> 괄호를 생략할 시 (38, 0)으로 자동 지정됩니다.
- VARCHAR2(byte) -> 괄호 안에 들어올 문자열의 최대 길이를 지정. (4000byte까지)
- CLOB -> 대용량 텍스트 데이터 타입 (최대 4Gbyte)
- BLOB -> 이진형 대용량 객체 (이미지, 파일 저장 시 사용)
- DATE -> BC 4712년 1월 1일 ~ AD 9999년 12월 31일까지 지정 가능
- 시, 분, 초 지원 가능.
*/

CREATE TABLE dept (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14),
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bocus NUMBER(10)
);

SELECT * FROM dept;

DESC dept;

INSERT INTO dept
VALUES(10, '영업부', '서울', sysdate, 1000000);

INSERT INTO dept
VALUES(11, '개발부', '경기도', sysdate, 3000000);

INSERT INTO dept
VALUES(12, '마케팅', '인천', sysdate, 2000000);

DELETE FROM dept WHERE loca = '경기도'; 

-- 데이터 삽입 시, NUMBER와 VARCHAR2의 길이를 반드시 확인해야함.

INSERT INTO dept
VALUES(12, '부서명이따로없는데어떡하지', '서울', sysdate, 1000000);


-- 테이블의 구조를 변경하는 명령어

-- 컬럼추가
ALTER TABLE dept
ADD dpet_count NUMBER(3);  -- dept테이블에 3자리 정수를 받는 dept_count라는 컬럼을 추가

-- 컬럼명 수정
ALTER TABLE dept
RENAME COLUMN dpet_count TO emp_count;

-- 컬럼 속성 변경 --> 데이터타입과 길이를 변경
-- 속성 변경 시, 기존의 데이터와 맞지 않는 타입이나 길이로는 변경이 불가능함.
ALTER TABLE dept
MODIFY dept_no NUMBER(4);

-- DDL(CREATE, ALTER, TRUNCATE, DROP)은 트랜잭션 대상이 아님. 즉, 자동으로 커밋됨.
-- DML(INSERT, UPDATE, DELETE) 이후 DDL을 실행하면 자동으로 커밋이 됨.


-- 컬럼 삭제
ALTER TABLE dept
DROP COLUMN dept_bocus;

-- 테이블 이름 변경
ALTER TABLE dept
RENAME TO dept2;

SELECT * FROM dept2;

-- 테이블 삭제 (구조는 남겨두고 데이터만 모두 삭제)
TRUNCATE TABLE dept2;

-- 테이블 자체를 삭제
DROP TABLE dept2;

















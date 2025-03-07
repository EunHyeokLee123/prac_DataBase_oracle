-- 테이블 생성과 제약조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음. (필수값)
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK: 정의된 형식만 저장되도록 허용.


-- 컬럼 레벨 제약 조건 (컬럼 선언마다 제약조건 지정)
-- 제약조건 식별자는  생략이 가능함. (오라클이 알아서 생성)
CREATE TABLE dept(
    dept_no NUMBER(2) CONSTRAINT dept_deptno_pk PRIMARY KEY,  -- 제약조건 이름은 지목하지 않아도 됨.
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept_dept_name_uk UNIQUE,  -- NULL 및 중복 입력불가.
    -- 참조하려는 컬럼의 타입과 길이가 동일해야 함.
    loca NUMBER(4) CONSTRAINT dept_loca_locid_fk REFERENCES locations(location_id),
                                                    -- locations 테이블의 location_id를 참조한다는 의미
    dept_bonus NUMBER(10) CONSTRAINT dept_bonus_ck CHECK(dept_bonus > 100000),  -- 커스텀 제약조건
    man_gender VARCHAR2(1) CONSTRAINT dept_gender_ck CHECK(man_gender IN('M','F'))
);

DROP TABLE dept2;

-- 테이블 레벨 제약 조건 (모든 열 선언 후 제약조건을 한번에 취하는 방식)
CREATE TABLE dept (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no), 
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 100000),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

DESC dept;
SELECT * FROM dept;

INSERT INTO dept
VALUES(10,'aa', 1800, 1000000,'M');

-- 외래 키는 부모(참조)테이블에 없는 값은 INSERT할 수 없음.
INSERT INTO dept
VALUES(20,'bb', 2000, 1000000,'M'); -- 에러, 부서번호가 중복되기에 UNIQUE 제약조건 위반

-- UPDATE(데이터 수정)할 때도, 제약 조건에 맞는 데이터 값을 넣어야 한다.
UPDATE dept
SET loca = 4000  -- FK(외래 키) 제약 조건 위반
WHERE dept_no = 10;

-- 타 테이블에서 나의 PK를 외래 키로 사용되는(참조하는) 컬럼(또는 테이블)은 삭제가 불가능하다.
DELETE FROM locations
WHERE location_id = 1800;



-- 테이블 생성 이후 제약조건 추가 및 변경, 삭제
-- 제약조건은 추가, 삭제만 가능합니다. 변경은 안됩니다.
-- 변경하려면 삭제하고 새로운 내용으로 추가하면 됩니다.

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- PK 추가
ALTER TABLE dept2
ADD CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no);

-- UNIQUE 추가
ALTER TABLE dept2
ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

-- FK 추가
ALTER TABLE dept2
ADD CONSTRAINT dept2_loca_locid_fk 
FOREIGN KEY(loca) REFERENCES locations(location_id);

-- CHECK 추가
ALTER TABLE dept2
ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 10000);

ALTER TABLE dept2
ADD CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'));

-- NOT NULL은 열 수정 형태로 변경합니다.
ALTER TABLE dept2
MODIFY dept_bonus NUMBER(10) NOT NULL;


-- 제약 조건 확인
SELECT * FROM user_constraints
WHERE table_name = 'DEPT';  -- 테이블명은 대문자로 작성해야함.











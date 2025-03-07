-- 시퀀스 (순차적으로 증가, 감소하는 값을 만들어 주는 객체)

CREATE SEQUENCE test_seq
    START WITH 1   -- 시작값 (기본값은 증가할 때는 최소, 감소할 때는 최대값)
    INCREMENT BY 1 -- 증감값 (기본값은 1, 양수면 증가, 음수면 감소)
    MAXVALUE 10    -- 최대값  (기본값은 1027, 감소할 때는 -1)
    MINVALUE 1     -- 최소값, 증감값에 따라 최대, 최소 둘 중 하나만 기재하면 됨.
                    -- 증가일 때는 1, 감소일 때는 -1028
    NOCACHE        -- 캐시 메모리 사용 여부(NOCACHE(기본값), CACHE로 표기)
    NOCYCLE;       -- 순환 여부, 순환한다면 최대(최소)값에 도달하면 다시 시작값으로 돌아감.
    
    
CREATE TABLE test_tbl(
    test_no NUMBER(2) PRIMARY KEY,
    test_msg VARCHAR2(100)
);

INSERT INTO test_tbl
VALUES(test_seq.NEXTVAL, 'test'); -- INSERT 실행 시 시퀀스의 다음 값 활용
                                   -- 시퀀스가 순환하지 않아서, 최대값 도달하면 더이상 삽입 불가능
SELECT * FROM test_tbl;

SELECT
    test_seq.CURRVAL
FROM dual;











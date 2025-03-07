SHOW AUTOCOMMIT;  
-- autocommit의 활성화여부
                    -- 활성화되어 있으면 자동으로 커밋되기에
                    -- 사용자가 커밋을 제어 불가능
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

INSERT INTO emps
VALUES(300, '춘식이', 'IT_PROG', '25/03/07');

DELETE FROM emps WHERE employee_id =100;

ROLLBACK;

INSERT INTO emps
VALUES(100, '메롱이', '영업부', sysdate);

-- 보류중인 모든 데이터 변경사항을 취소 (폐기)
-- 직전 커밋 단계로 회귀(돌아가기) 및 트랜잭션 종료.
ROLLBACK;

-- 세이브 포인트 생성
-- 롤백할 포인트를 직접 이름을 붙여서 지정
-- ANSI 표준 문법은 아니기에, 오라클에서만 사용.
-- 권장하지 않음

SAVEPOINT insert_Chun;

ROLLBACK TO SAVEPOINT insert_Chun;

-- 데이터베이스에 변경사항을 영구적으로 저장
-- 커밋 후에는 어떤 방법을 사용하더라도 되돌릴 수 없음.
COMMIT;










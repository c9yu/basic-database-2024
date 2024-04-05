-- 트랜스액션(트랜잭션)
-- SELECT 만 있으면 굳이 트랜잭션을 안걸어도 된다.ABORT
-- INSERT, UPDATE, DELETE에서 중요한 로직을 처리할 때 트랜잭션이 반드시 필요하다

SELECT *
  FROM Customer;


-- 트랜잭션은 실수를 방지하기 위해서 사용------------------

BEGIN TRAN; -- 트랜잭션 시작

--- CUD에 대한 쿼리---
UPDATE Customer
   SET phone = '010-7777-8888'
 WHERE custid = 2;
---------------------

COMMIT -- 제대로 넣으면 COMMIT
ROLLBACK -- 잘못 넣으면 ROLLBACK

/*
 내가 실행할 쿼리가 무언가 큰 문제가 발생할 가능성이 있다.
 그렇다면 BEGIN TRAN을 걸고, 쿼리를 실행한 뒤
 결과를 확인해 보았을 때 문제가 없다면 -> COMMIT
 문제가 있다면 -> ROLLBACK

 한번 ROLLBACK or COMMIT을 진행했다면 TRAN은 종료된다
 다시 ROLLBACK or COMMIT이 필요하다면 다시 TRAN을 실행시켜줘야 함.
*/
---------------------------------------------------------
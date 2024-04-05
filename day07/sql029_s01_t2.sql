-- 트랜잭션 2

BEGIN TRANSACTION; -- 1

USE madang; -- 2

/*
-------------------
SELECT * 
FROM   Book
WHERE  bookid=1; 
------------------- 3 ㄴ. 여기까지 실행을 하면 락이 걸린다.

t1에서 COMMIT을 실행시키지 않으면 t2에서 동일한 데이터에 접근 이 불가하다 ('락'이 걸렸다)
*/

UPDATE Book 
SET     price=price+100
WHERE  bookid=1;


/* Commit 과 동시에 결과 나타남 */

SELECT * 
FROM   Book
WHERE  bookid=1;



COMMIT;
ROLLBACK;
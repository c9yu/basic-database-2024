-- 트랜잭션 1

BEGIN TRANSACTION; -- 1

USE madang; -- 2

-------------------
SELECT *  
FROM   Book
WHERE  bookid=1;
------------------- 3

-------------------
UPDATE Book 
SET     price=7100
WHERE  bookid=1;
------------------- 4

------------------------------------------ ㄱ. 여기까지 실행 후 t2로 이동

SELECT * 
FROM   Book
WHERE  bookid=1;

 

COMMIT;
ROLLBACK;
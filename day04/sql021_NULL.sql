-- NULL에 대한 소찰
-- MyBook 테이블에서 시작

-- 'NULL + 숫자' 연산의 결과는 NULL
SELECT bookid
     , price + 100
  FROM myBook

SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
  FROM MyBook;

SELECT (10000 + 20000 + 0)/3;

-- bookid가 없는 데이터로 통계를 낼 때는 NULL이 나와야 한다.
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
  FROM MyBook
 WHERE bookid >= 4;

-- NULL 비교(!)
-- NULL은 일반 비교연산자로 비교X
-- IS / IS NOT

SELECT *
  FROM MyBook
 WHERE price IS NULL; -- IS NOT NULL;

-- ISNULL() 함수
-- 사전 작업 (Customer 테이블)
SELECT *
  FROM Customer
 WHERE phone IS NULL;

UPDATE Customer
   SET phone = NULL
 WHERE custid = 2;

-- NULL 인 경우 빈 공간이 나와버리는데 이를 다른 표기로 대체해 준다. (값 자체는 NULL이다.)
SELECT custid
     , [name]
     , [address]
     , ISNULL(phone, '연락처 없음') AS phone
  FROM Customer;   

-- TOP n 내장된 키워드 (함수 X)
SELECT TOP 3 orderid, custid, saleprice
  FROM Orders
 ORDER BY saleprice DESC;
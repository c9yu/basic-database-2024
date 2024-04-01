-- 전체 고객 중 도서를 구매하지 않은 고객의 이름을 조회
SELECT [name]
  FROM Customer
EXCEPT
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders);


 -- 합집합 (중복 허용 X)
SELECT [name]
  FROM Customer
UNION
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- 합집합 (중복 허용 O)
SELECT [name]
  FROM Customer
UNION ALL
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid FROM Orders);


-- 교집합
   SELECT [name]
     FROM Customer
INTERSECT
   SELECT [name]
     FROM Customer
    WHERE custid IN (SELECT DISTINCT custid FROM Orders);


-- UNION - 각 컬럼의 타입형이 일치해야 한다.
SELECT bookid    -- int
     , bookname  -- varchar(40)
  FROM Book
 UNION
SELECT custid    -- int
     , [name]
  FROM Customer;


  -- EXIST
  SELECT [nameg]
  SELECT *
    FROM Orders AS o
   WHERE o.custid IS NOT NULL
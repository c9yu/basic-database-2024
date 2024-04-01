-- Q. 책가격이 가장 비싼 책
/*
 SELECT MAX(price)
    FOM Book;
 bookname이 GROUP BY에 없어서 에러가 난다.
*/


-- Q. 35,000인 것을 찾아보자
SELECT *
  FROM Book
 WHERE price = 35000;


-- Q. 서브쿼리를 쓰면 한번에 실행 가능
SELECT bookname
  FROM Book
 WHERE price = (SELECT MAX(price)
                  FROM Book);


-- Q. 도서를 구매한 적이 있는 고객이름 검색 (서브쿼리 사용) 
SELECT [name] AS '고객 이름'
  FROM Customer
 WHERE Custid IN (SELECT DISTINCT custid -- IN을 사용하면 구매한 적 있는사람
                      FROM Orders);      -- NOT IN을 사용하면 구매한 적 없는사람


-- Q. 도서를 구매한 적이 있는 고객이름 검색 (JOIN 사용) 
SELECT DISTINCT c.[name] AS '고객 이름'
  FROM Customer AS c, Orders AS O
 WHERE c.custid = o.custid


 -- Q. 도서를 구매한 적이 없는 고객이름 검색 (JOIN 사용) 
SELECT DISTINCT c.[name] AS '고객 이름'
  FROM Customer AS c LEFT OUTER JOIN Orders AS O
    ON c.custid = o.custid
 WHERE o.orderid IS NULL;

----------------------------------------------------------------------------
 -- Q. 도서를 구매한 적이 있는 고객이름 검색 (서브쿼리 FROM 절 X)
 SELECT b.bookid
      , b.bookname
      , b.publisher
      , o.orderdate
      , o.orderid
   FROM Book AS b, Orders AS O
  WHERE b.bookid = o.bookid

-- Q. 도서를 구매한 적이 있는 고객이름 검색 (서브쿼리 FROM 절 O)
SELECT t.*
   FROM (
        SELECT b.bookid
             , b.bookname
             , b.publisher
             , o.orderdate
             , o.orderid
          FROM Book AS b, Orders AS O
         WHERE b.bookid = o.bookid
        ) AS t;
-- SELECT로 만든 실행 결과(가상의 테이블)를 마치 DB에 있는 테이블처럼 사용 가능
----------------------------------------------------------------------------

-- 서브쿼리 SELECT 절
-- 무조건 1건에 1컬럼
SELECT o.orderid
     , o.custid
     , (SELECT name FROM Customer WHERE custid = o.custid) AS '고객명'
     , o.bookid
     , (SELECT bookname FROM Book WHERE bookid = o.bookid) AS '도서명'
     , o.saleprice
     , o.orderdate
  FROM Orders AS o;


-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 조회
-- 서브쿼리 두 번 사용
-- 가장 안쪽의 쿼리가 실행 -> 그 다음 쿼리 실행 -> 가장 바깥의 쿼리 실행
SELECT [name]
  FROM Customer
 WHERE custid IN (SELECT custid
                    FROM Orders
                   WHERE bookid IN (SELECT bookid
                                      FROM Book
                                     WHERE publisher = '대한미디어'));
-- 좋은 방법은 아니다 이 경우 JOIN이 더 유용하다.


-- 계산결과를 서브쿼리로 사용
-- 각각의 출판사의 도서 평균가격을 넘은 책들만 조회
SELECT b1.*
  FROM Book b1
 WHERE b1.price > (SELECT AVG(b2.price)
                     FROM Book b2 -- AS 생략 가능
                    WHERE b2.publisher = b1.publisher);

-- 각 출판사별 평균 가격
SELECT AVG(b2.price), b2.publisher
  FROM Book b2
 GROUP BY b2.publisher;
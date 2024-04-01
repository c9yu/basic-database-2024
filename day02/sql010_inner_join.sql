-- 두 개 이상의 테이블 SQL 쿼리 작성
-- Customer, Orders 테이블을 동시에 조회

 /*
SELECT *
  FROM Customer;

SELECT *
  FROM Orders;

이 경우 쿼리를 한 번 달린 것이 아닌, 두 번 달린 것이다. 
 */ 

-- Q. Customer, Orders 테이블을 동시에 조회하라(조건없이)
SELECT *
  FROM Customer, Orders; 
  -- 50개 행이 출력, 그러나 이는 제대로 알아 볼 수 없는 의미없는 출력이다.
  -- 이는 조건이 제대로 달려있지 않기 때문이다.


-- 1. RDB(관계형 데이터베이스)에서 가장 중요한 쿼리문 -> JOIN이라고 한다.

-- Q. Customer, Orders 테이블을 동시에 조회하라(둘의 custid가 일치한다는 조건)


SELECT *
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid -- Customer, Orders 둘의 custid가 일치한다는 의미의 WHERE 절
 ORDER BY Customer.custid ASC;
  -- 10개 행이 출력, 정확히 출력된다.


-- Q. 주문한 책의 고객이름과 책 판매액 조회
SELECT Customer.[name]
     , Orders.saleprice
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;


-- Q. 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬
SELECT Customer.[name] -- 고객별(이름)로 표시
     , SUM(Orders.saleprice) AS '총 판매액' -- 총 판매액
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid -- 둘의 custid 가 같다는 조건
 GROUP BY Customer.[name]
 ORDER BY Customer.[name] -- 정렬


 -- 각 테이블의 별명으로 줄여서 쓰는게 일반적
 -- 지금과 같이 양쪽의 수가 딱 일치할 때 하는 join을 내부 조인, inner join이라고 한다.
 SELECT c.custid
      , c.[name]
	  , c.[address]
	  , c.phone
	  , o.orderid
	  , o.custid
	  , o.bookid
	  , o.saleprice
	  , o.orderdate
  FROM Customer AS c, Orders AS o
 WHERE c.custid = O.custid -- Customer, Orders 둘의 custid가 일치한다는 의미의 WHERE 절
 ORDER BY C.custid ASC;


-- 3개 테이블 Join : 표준 SQL이 아닌 축약형이다.
SELECT * -- 컬럼별로 나누어 적는 것은 생략
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid 
   AND o.bookid = b.bookid


/* 
 SELECT *
   FROM Customer AS c
  INNER JOIN Orders AS o
     ON c.custid = o.custid
  INNER JOIN Book AS b
     ON o.bookid = b.bookid;

-- 실제 표준 SQL의 Inner Join의 경우 위와 같이 보다 복잡하기 때문에
-- 축약형을 지원한다.
*/


-- Q. 가격이 20,000원 이상인 도서를 주문한 고객의 이름과, 도서명을 조회하라

/*
 -- JOIN을 사용하지 않는 경우

 SELECT *
   FROM Orders AS o
  WHERE o.bookid IN (3, 7)

 SELECT *
   FROM Book AS b
  WHERE b.price >= 20000

 SELECT *
   FROM Customer AS c
  WHERE c.custid IN (1, 4)

  이처럼 Join을 사용하지 않고 문제를 해결하려고 하면 너무 복잡하거나 불가능하다.
*/

 -- Join을 사용하는 경우
SELECT c.[name]
     , b.bookname
	 , o.saleprice
	 , b.price
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid
   AND b.price >= 20000;
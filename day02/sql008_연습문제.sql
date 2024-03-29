-- 연습문제 PART 1.

-- 1. 도서번호가 1인 도서 검색
SELECT *
  FROM Book
 WHERE bookid = 1;

-- 2. 가격이 20,000원 이상인 도서 검색
SELECT *
  FROM Book
 WHERE price >= 20000;

-- 3. 박지성의 총 구매액
SELECT *
  FROM Customer; -- 박지성의 custid를 확인

SELECT SUM(saleprice) AS '박지성 총 구매액'
  FROM Orders
 WHERE custid = 1; -- 확인한 custid를 통해 작성

-- 4. 박지성이 구매한 도서의 수
SELECT COUNT (custid) AS '박지성이 구매한 도서의 수'
  FROM Orders
 WHERE custid = 1;

-- 집계 함수, GROUP BY
-- 고객이 주문한 도서의 총 판매액

SELECT sum(saleprice) -- sum(합칠 것) 형태로 사용된다.
  FROM Orders;


SELECT sum(saleprice) AS [총 매출] -- sum으로 합친 것을 [총 매출]이라는 이름으로 사용하겠다.
  FROM Orders;
 
 /*
AS를 통해 별칭을 만들어 줄 때 띄워쓰기는 불가능하다.
만약 띄워쓰기를 사용하고 싶다면 [] or '' 를 통해 사용 가능하다.

총매출 : O, 총 매출 : X, [총 매출] : O
 */

-- Q. 김연아 고객이 주문한 도서의 총 판매액

-- step 1.
SELECT *
  FROM Customer; -- 김연아의 custid가 2임을 알 수 있다.

-- step 2.
SELECT sum(saleprice) AS '김연아 고객 총 판매액'
  FROM Orders
 WHERE custid = 2; -- step1에서 찾은 cust id를 통해 작성

-- COUNT()는 * 을 사용할 수 있다.
-- 그러나, 나머지 집계함수는 열(컬럼) 하나만 지정해서 사용 할 것.
SELECT count(saleprice) AS [주문 개수]
     , SUM(saleprice) AS [총 판매액]
	 , AVG(saleprice) AS [판매액 평균]
	 , MIN(saleprice) AS [주문 도서 최소 금액]
	 , MAX(saleprice) AS [주문 도서 최대 금액]
  FROM Orders;

-- 중복제거 된 출판사의 수
SELECT COUNT(DISTINCT publisher)
  FROM Book;

-- GROUP BY : 필요조건으로 그룹핑을 해서 결과(통계)를 내기 위함.

/*
 SELECT *
   FROM Orders
  GROUP BY custid;
*/
-- 오류가 발생한다 GROUP BY는 집계함수 없이 사용할 수 없다.

 SELECT SUM(saleprice) AS '판매액' 
   FROM Orders
  GROUP BY custid;
-- 사용 가능

/*
 SELECT custid, bookid SUM(saleprice) AS '판매액' 
   FROM Orders
  GROUP BY custid;
*/
-- 오류가 발생한다.
-- GROUP BY절에 들어있는 컬럼 외에는 SELECT문에 절대 사용 할 수 없음
-- 단, saleprice는 집계함수 안에 들어있으므로 예외이다.

 SELECT custid, SUM(saleprice) AS '판매액' -- custid는 GROUP BY절에 들어있으니 사용 가능하다.
   FROM Orders
  GROUP BY custid; 

-- HAVING - WHERE 절은 일반 필터링 조건
-- HAVING은 통계, 집합 함수의 필터링 조건
-- 가격이 8,000원 이상인 도서를 구매한 고객에 고객별 주문도서 총수량
-- 단, 2권 이상 구매한 경우만

SELECT custid, COUNT(*) AS [구매수]
  FROM Orders
 WHERE saleprice >= 8000
 GROUP BY custid
HAVING COUNT(*) >= 2;
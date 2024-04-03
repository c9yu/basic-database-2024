-- 서브쿼리 리뷰
-- ALL, SOME(ANY)
-- ALL, SOME(ANY)를 사용하는 조건은 아래의 데이터에서는 사용이 어렵다.



-- 3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 다른 주문의 주문번호, 금액을 출력하라
SELECT *
  FROM Customer;

-- 장미란이 주문한 내역 중 최고 금액
SELECT MAX(saleprice)
  FROM Orders
 WHERE custid = 3;
-- 외래키는 중복 가능!

-- 13000원 보다 비싼 도서를 구입한 주문번호, 금액
SELECT o1.orderid
     , o1.saleprice
  FROM Orders AS o1
 WHERE o1.saleprice > ALL (SELECT MAX(saleprice) -- ALL(혹은 ANY)를 붙이나 붙이지 않으나 결과에 차이는 없다.
                             FROM Orders
                            WHERE custid = 3);

-- EXISTS, NOT EXISTS - 열을 명시 안함
-- 대한민국 거주 고객에게 판매한 도서의 총 판매액
-- 전체 판매액 : 118,000원, 대한민국 고객 판매액 46,000원
SELECT SUM(saleprice) AS '대한민국 고객 판매액'
  FROM Orders AS o
 WHERE EXISTS (SELECT *
                 FROM Customer AS c
                WHERE c.address LIKE '%대한민국%'
                  AND c.custid = o.custid);

-- 조인을 사용해도 동일한 결과를 얻어낼 수 있다.
SELECT SUM(saleprice) AS '조인도 가능'
  FROM Orders AS o, Customer AS c
 WHERE o.custid = c.custid
   AND c.address LIKE '%대한민국%'; -- NOT LIKE를 사용하면 대한민국에 거주하지 않는 고객 판매액을 구할 수 있다.


-- SELECT절 서브쿼리 
-- JOIN으로 변경 가능, 이미 쿼리가 너무 복잡해서 더 이상 테이블을 추가하기 힘들면,
-- 많이 사용
-- 고객별 판매액을 보이시오.
SELECT SUM(o.saleprice) AS '고객별 판매액' -- SUM은 숫자 형태만 들어간다. EX) orderdate 등은 들어갈 수 없음
     , o.custid -- GROUP BY에서 custid를 사용했으니 SELECT에서도 custid만 사용 가능
     , (SELECT [name] FROM Customer WHERE custid = o.custid) AS '고객명'
  FROM Orders AS o 
 GROUP BY o.custid; -- GROUP BY가 들어가면 SELECT절에 반드시 집계함수가 들어가야 함!


-- 위의 문제도 JOIN으로 가능

-- UPDATE에서도 사용 가능
-- 사전 준비
ALTER TABLE Orders ADD bookname VARCHAR(40); -- Orders에 bookname이라는 테이블을 추가했다.

-- UPDATE, 한꺼번에 필요한 필드값을 한테이블에서 다른 테이블로 복사할 때 아주 유용함
UPDATE Orders
   SET bookname = (SELECT bookname
                     FROM Book
                    WHERE Book.bookid = Orders.bookid);


-- FROM절 서브쿼리(인라인 뷰[가상 테이블])
-- 고객별 판매액을 고객명과 판매액으로 보이시오(서브쿼리 --> 조인)
-- 고객별 판매액 집계 쿼리가 FROM절에 들어가면 모든 속성(컬럼)에 이름이 지정되어야 함

SELECT b.*
  FROM (SELECT SUM(o.saleprice)
             , o.custid
          FROM Orders AS o 
         GROUP BY o.custid) AS b, Customer AS c 
 WHERE b.custid = c.custid


 -- 고객번호가 2 이하인 고객의 판매액을 보이시오, (고객이름과 판매액 표시)
 -- !!주의!! : GROUP BY 에 들어갈 속성(컬럼)은 최소화. 중복 등의 문제가 있으면 결과가 다 들어간다.
SELECT SUM(o.saleprice) AS '고객별 판매액'
     , (SELECT name FROM Customer WHERE custid = c.custid) AS '고객명'
  FROM(SELECT custid 
            , [name]
         FROM Customer
        WHERE custid <= 2)AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.custid, c.name
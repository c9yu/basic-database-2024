-- 1. 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객 이름
SELECT DISTINCT custid
  FROM Orders
 WHERE bookid IN (SELECT bookid
                    FROM Book
                   WHERE publisher IN (SELECT b.publisher
                                         FROM Customer AS c, Orders AS o, Book AS b
                                        WHERE c.custid = o.custid
                                          AND o.bookid = b.bookid
                                          AND c.[name] = '박지성'));

-- 3. 전체 고객에서 30% 이상이 구매한 도서
SELECT b.custid
     , CONVERT(float, b.custCount) / b.totalCount
  FROM (SELECT custid
             , COUNT(custid) AS custCount
             , (SELECT SUM(custid) FROM Orders) AS totalCount
          FROM Orders
         GROUP BY custid)AS b
 WHERE CONVERT(float, b.custCount)/b.totalCount >= 0.3;
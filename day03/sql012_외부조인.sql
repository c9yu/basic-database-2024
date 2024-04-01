SELECT c.custid
     , c.[name]
     , c.[address]
     , c.phone
     , o.orderid
     , o.custid
     , o.bookid
     , o.saleprice
     , o.orderdate
  FROM Customer AS c LEFT OUTER JOIN Orders AS o
-- FROM Customer AS c RIGHT OUTER JOIN Orders AS o 
-- RIGHT OUTER JOIN의 경우 INNER JOIN과 같은 결과가 출력된다.
    ON c.custid = o.custid
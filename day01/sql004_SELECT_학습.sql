-- Q. 모든 도서의 이름과 가격을 검색하시오.

-- Ctrl + Shift + U --> 대문자, Ctrl + Shift + L --> 소문자

SELECT bookname, price
  FROM Book;

-- Q. 모든 도서의 가격과 이름을 검색하시오.
SELECT price, bookname
  FROM Book;

-- 모든 도서의 도서번호, 도서 이름, 출판사, 가격을 검색하시오.
SELECT *
  FROM Book;

-- 실무에서는 모든 컬럼명을 다 적는 것이 일반적이다.
SELECT bookid, bookname, publisher, price
  FROM Book;

-- 도서 테이블에 있는 모든 출판사를 검색하시오.
SELECT publisher  
  FROM Book; -- 이 경우 중복이 발생한다.

-- 도서 테이블에 있는 모든 출판사를 검색하시오(중복 제거).
SELECT DISTINCT publisher -- 중복제거는 중복을 제거 할 수 있는(중복이 존재하는) 컬럼에서만 사용한다
  FROM Book;

-- 조건 검색(조건 연산자 사용)
-- Q. 가격이 20,000원 미만인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE price < 20000;

-- 가격이 10,000원 이상, 20,000원 이하인 도서를 검색하시오
SELECT *
  FROM Book
 WHERE price >= 10000 AND price <= 20000;

SELECT *
  FROM Book
 WHERE price BETWEEN 10000 AND 20000;

 /*
구간을 정해서 검색을 진행할 때는 두가지 방법으로 사용이 가능하다.
그러나 BETWEEN의 경우 초과, 미만에는 사용할 수 없다는 단점이 있다.
 */

-- Q. 출판사가 굿스포츠와 대한미디어인 도서를 검색하시오.
 SELECT *
   FROM Book
  WHERE publisher IN('굿스포츠', '대한미디어');

-- 축구의 역사를 출판한 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname = '축구의 역사';

-- 도서 이름에 축구가 포함된 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구%'; -- '축구%' : 축구라는 글자로 시작하는

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구'; -- '%축구' : 축구라는 글자로 끝나는

-- 두 글자에 구로 끝나는 단어로 시작되는 출판사를 검색하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '_구%'; -- '_구%' : ( _ :무슨 글자든 한 글자가 들어간) 구라는 글자로 시작하는
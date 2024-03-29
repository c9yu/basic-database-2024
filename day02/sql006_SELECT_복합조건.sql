-- 조회 : 복합 조건

-- Q. 축구에 관한 도서 중 20,000원 이상인 도서를 검색하시오.
SELECT bookid
	 , bookname
	 , publisher
	 , price
  FROM Book
 WHERE bookname LIKE '%축구%' -- %축구% : 축구라는 단어가 포함된
   AND price >= 20000;


-- Q. 출판사가 굿스포츠 혹은 대한미디어 인 도서 검색
SELECT *
  FROM Book
 WHERE publisher = '굿스포츠'
    OR publisher = '대한미디어'


-- 정렬
SELECT *
  FROM Book
 ORDER BY bookname; -- 한글 ㄱ~ㅎ 순서 -> 영문 순으로 정렬된다.

 /*
정렬은 기본적으로 ASC(Ascending : 오름차순)이다.
ASC  : (Ascending : 오름차순)
DESC : (Descending : 내림차순)
 */


-- Q. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색
SELECT *
  FROM Book
 ORDER BY price ASC, bookname DESC; -- 가격을 오름차순으로 정렬, 같은 가격인 경우 이름 내림차순으로 정렬

SELECT *
  FROM Book
 ORDER BY price ASC, bookname ASC; -- 가격을 오름차순으로 정렬, 같은 가격인 경우 이름 오름차순으로 정렬


-- Q. 도서 가격은 내림차순, 출판사는 오름차순으로 검색
SELECT *
  FROM Book
 ORDER BY price DESC, publisher ASC;

SELECT *
  FROM Book
 ORDER BY bookid DESC; -- 최근에 등록된 책부터 -> 오래된 책 순으로 검색
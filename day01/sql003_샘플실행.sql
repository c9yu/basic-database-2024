-- 책중에서 '축구의 역사' 라는 도서의 출판사와 가격을 알고 싶어.
-- dbo는 DataBase Owner(지금은 패스)

-- 키워드로 들어가는 문자들은 전부 대문자로 사용하는 버릇

SELECT publisher, price -- DML(4가지) 중 SELECT(조회)
  FROM Book 
 Where bookname = '축구의 역사'; 
 
/*
 SQL은 python, C, C++과 달리 거의 유일하게 == 이 아닌, = 하나만 사용한다.
 SQL은 문자열을 나타낼 때 "" 이 아닌 '' 을 사용한다.
 SQL은 대소문자 구분이 없지만, 키워드는 대문자로 사용한다.
 SQL은 ;이 필수가 아니지만, 중요한 상황에서는 사용할 것
*/

-- USE basic2024; 이 경우에 Madang에 포함되어 있는 publisher, price, Book, bookname 등등을 사용할 수 없게 된다.

/*
 코드를 통해 입력한 것은 실제 생성된 테이블이며,
 F5를 통해 실행할 경우 생성되는 테이블은 가상테이블이다.
*/

-- 김연아 고객의 전화번호를 찾으시오.

-- step 1
SELECT * -- " *(= ALL이라고 부른다.) 즉, SELECT * 은 전체에서 검색을 의미 "
  FROM Customer;

-- step 2 (step 1에서 수정)
SELECT *
  FROM Customer
 WHERE [name] = '김연아'; -- 특정 구간만 드래그하여 F5를 누를 경우 해당 구간만 실행된다.

-- step 3 (step 2에서 수정)
SELECT phone
  FROM Customer
 WHERE [name] = '김연아';

 /*
한번에 step 3의 구문이 나오는 것이 아니라
3개의 step을 순서대로 거치며 작성하는 것이 편리하다.
 */
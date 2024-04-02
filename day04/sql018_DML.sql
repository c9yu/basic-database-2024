-- 삽입(INSERT)
INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES (11, '스포츠 의학', '한솔의학서적', 90000);

-- 실행 결과가 '1개 행이 영향을 받음' 이라 떠야 정상

--컬럼 순서를 변경가능
INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES (11, '스포츠 의학', 90000, '한솔의학서적');

-- 속성리스트를 생략가능(컬럼이 완전 일치)
-- 컬럼갯수만큼 일치하게 값을 넣어야하고 순서도 맞아야 함
INSERT INTO Book
    VALUES (12, '스포츠 의학2', '한솔의학서적', 90000);

-- 값을 생략가능(단, 값을 생략하면 컬럼을 다 지정해줘야 함)
INSERT INTO Book(bookid, bookname, publisher)
    VALUES (13, '스포츠 의학3', '한솔의학서적');

-- 새 테이블 생성
-- 여기는 3장에서 사용되는 Imported_book 테이블
CREATE TABLE Imported_Book (
  bookid      INT,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INT 
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

-- 특수 INSERT INTO ... SELECT ...
-- Imported_Book에 있던 책들을 Book에 삽입
INSERT INTO Book(bookid, bookname, publisher, price)
    SELECT bookid, bookname, publisher, price
      FROM Imported_Book;

-- 수정(UPDATE)
-- 사전 준비, 이전의 Customer 테이블 내용을 CustomerNew로 복사
SELECT custid, [name], [address], phone
  INTO CustomerNew
  FROM Customer;

-- Customer 테이블에서 고객번호가 5인 고객의 주소를 대한민국 부산으로 변경
UPDATE Customer
   SET [address] = '대한민국 부산'
 WHERE custid = 5;

-- CustomerNew 에서 고객번호가 5인 고객의 주소를 대한민국 광주로 변경
UPDATE CustomerNew
   SET [address] = '대한민국 광주'
 WHERE custid = 5;

-- Customer 테이블에서 박세리 고객의 주소를 김연아 주소로 변경
UPDATE Customer
   SET [address] = (SELECT [address]
                      FROM Customer
                     WHERE [name] = '김연아') -- WHERE절이 빠지면 안됨
  WHERE [name] = '박세리';

-- 수정은 여러컬럼(속성) 같이 가능
UPDATE CustomerNEW
   SET [name] = '박채리'
     , [address] = '미국 보스턴'
     , phone = '+01 010-9999-0000'
 WHERE custid = 5;
 
-- 삭제
DELETE FROM Customer
 WHERE custid = 5;      -- 박세리 삭제됨

-- 수정, 삭제는 항상 트랜잭션과 같이 실행해야 함

-- 1. 새로운 도서('스포츠 세계', '대한미디어', 10,000원)가 마당서점에 입고되었다. 삽입이 안 될 때 필요한 데이터가 더 있는지 찾아보시오.
INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES(14, '스포츠 세계', '대한미디어', 10000);


-- 2. '삼성당'에서 출판한 도서를 삭제하시오.
DELETE FROM Book
 WHERE publisher = '삼성당';

-- 3. '이상미디어'에서 출판한 도서를 삭제하시오. 삭제가 안되면 원인을 생각해 보시오.
DELETE FROM Book
 WHERE publisher = '이상미디어';


-- 4. 출판사 '대한미디어'를 '대한출판사'로 이름을 바꾸시오.
UPDATE Book
   SET publisher = '대한출판사'
 WHERE publisher = '대한미디어';
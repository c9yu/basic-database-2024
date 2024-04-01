-- DDL : 데이터 정의 언어
-- 객체 생성, 수정, 삭제

-- 1. NewBook이라는 테이블을 생성하라
/*
 bookid(도서 번호) - int
 bookname(도서 이름) - varchar(20)
 publisher(출판사) - varchar(20)
 price(가격) - int
*/

/*
 -- 타입 종류

 INT[정수], BIGINT[큰 정수], BINARY(n)[이진 데이터], BIT[0|1]
 CHAR(n)[고정 문자열], VARCHAR(n)[가변 문자열], NCHAR(n)/NVARCHAR(n) [유니코드 고정 문자열, 가변 문자열]
 N~ : 유니코드라는 뜻

 예(username : CHAR(10)/VARCHAR(10)) 'hugo'
 CHAR(10) = 'hugo      ' : 이름을 넣고 10개의 자리 중 남은 곳은 스페이스 입력
 VARCHAR(10) = 'hugo' : 이름을 넣고 10개의 자리 중 남은 곳은 전부 없앤다.

 DATE[날짜], DATETIME[날짜,시간], DECIMAL(18,0)[소수점 표현 실수], FLOAT[실수]
 IMAGE[이미지 바이너리], SMALLINT[255까지의 정수], TEXT[268까지의 텍스트] NTEXT[유니코드 26]

 -- 가장 많이 쓴느 타입
 INT, CHAR, VARCHAR, DATETIME, FLOAT, TEXT 외에는 잘 안쓴다.
*/

DROP TABLE Newbook; -- 테이블 삭제


CREATE TABLE NewBook(
    bookid INT,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INT
    PRIMARY KEY (bookid) -- 나는 'bookid'를 기본키로 사용하겠다.
)


CREATE TABLE NewBook(
    bookid INT,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INT
    PRIMARY KEY (bookid, bookname) -- 기본키를 두 개 이상
)

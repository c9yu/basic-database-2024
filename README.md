# basic-database-2024
IoT 개발자 과정 SQLServer 학습 리포지토리

## 1일차 (2024-03-28)
- MS SQL Server 설치: [최신버전 설치](https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads) 
    - DBMS 엔진 - 개발자 버전
        - 미디어 다운로드 선택
        - iso 선택/ 이후 경로 지정
        - iso 설치 완료되면 우클릭 후 탑재
        - setup.exe 더블클릭
            - 새 SQL Server 독립 실행형 설치 또는 기존 설치에 기능 추가
            - (온-프레미스(회사에서 직접 서버 운영) - 클라우드(클라우드 회사를 통해 서버 운영) : 반대 개념)
            - 무료 버전 지정 선택
            - Microsoft 업데이트를 통해 업데이트 확인(권장) 체크하지 않음
            - SQL Server에 대한 Azure 확장 체크하지 않음
            - 데이터베이스 엔진 서비스, SQL Server 복제, 검색을 위한 전체 텍스트 및 의미 체계 추출, Intergration Services만 선택
            - (여러개의 서버를 사용할 때를 제외하면 굳이 이름을 바꿀 필요는 없다.)
            - 데이터 정렬 탭에서 선택한 언어를 확인 가능
            - (Korean_Wansung_CI_AS, CI: 대소문자 구분 안함, AS: 악센트는 구분)
            - 데이터베이스 엔진 구성부터 중요
                - 현재 사용자 추가
                - 혼합모드(sa)에 대한 암호를 지정해줘야 한다./mssql_p@ss(8자 이상, (대소문자 구분), 특수문자 1자 이상 포함)
                - 데이터 디렉토리는 변경이 필요 할 수 있다.
                - (데이터 루트 디렉토리: C에 폴더를 하나 만들고 거기를 지정)
        - ![기능선택](https://raw.githubusercontent.com/c9yu/basic-database-2024/main/imamges/db001.png)

    - 개발툴 설치
        - SSMS(Sql Server Management Studio) DB에 접근하여 여러 개발작업을 가능하게 하는 툴
        - [개발툴 설치](https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) 
            - 한국어 버전 클릭하여 설치
            - 다운로드 된 파일을 열고 별도의 지정 없이 설치 하면 된다.
        
    - 데이터베이스 개념
        - 데이터를 보관, 관리, 서비스하는 시스템
        - Data, Information, Knowledge 개념
        - DBMS > Database > Data(Model)

    - DB 언어
        - SQL(Structured Query Language) : 구조화 된 질의 언어
            - DDL (Data Definition Language) : 데이터베이스, 테이블, 인덱스 생성 기능 CREATE, ALTER, DROP
            - DML (Data Manipulation Language) : 검색(SELECT), 삽입(INSERT), 수정(UPDATE), 삭제(DELETE) 기능 (!) : 가장 중요하다.
            - DCL (Data Control Language) : 보안, 데이터의 사용 권한 부여(GRANT)/제거(REVOKE) 기능
            - TCL (Transaction Control Language) : 트랜스액션(트랜잭션) 제어하는 기능 COMMIT, ROLLBACK
                - TCL의 경우 DCL에서 분리되어 나왔다.

    - SSMS 실행
        - SQL Server Management studio 접속
            - 인증 : SQL Server 인증으로 선택
                - 미리 지정해뒀던 패스워드 입력
            - 암호화 : 선택적
            - 이후 연결 클릭
    - ![SSMS 로그인](https://raw.githubusercontent.com/c9yu/basic-database-2024/main/imamges/db002.png)
        - 특이사항 : SSMS 쿼리창에서 소스코드 작성시 빨간색 오류 밑줄이 가끔 표현(전부 오류는 아니다.)

    - 설정
        - 도구 -> 옵션
            - 텍스트 편집기 : 모든 언어 줄번호 체크
            - 디자이너 : NULL 기본키 경고 체크, 테이블을 다시 만들어야 하는 변경 내용 저장 안함 체크해제
            - SQL Server 개체 탐색기 : 테이블 및 뷰 옵션 탭의 상위 n개 행 선택/편집 명령의 값 0으로 지정

    - 사용
        - 주석은 -- or /**/ 로 사용 가능하다.
        - 저장시에는 한글의 경우 깨질 수 있으니 utf-8로 인코딩하여 저장한다.
        - utf-8로 인코딩
            - 도구->옵션, 파일 확장명 탭에서 
            - 1. 확장명 sql 입력 후 편집기를 'SQL 쿼리 편집기(인코딩 사용)'을 선택 후 추가
            - 2. 확장명 없는 파일을 다음에 매핑 'SQL 쿼리 편집기(인코딩 사용)'을 선택
            - 3. 생성된 편집환경을 선택 후 적용 후 확인
            - 4. 이후 Ctrl + n 을 통해 새 쿼리를 만들때 utf-8로 인코딩을 선택하여 생성된 쿼리의 경우 자동으로 utf-8로 인코딩 된다.
        - Ctrl + n 을 통해서 새 쿼리를 생성 가능하다.
        - F5를 통해서 실행이 가능하며, 여러개의 SELECT 구문이 있을 경우 특정 구간만 드래그하여 F5를 눌러줄 경우 해당 구간만 실행된다.

    - DML 학습
        - SQL 명령어 키워드 : SELECT, INSERT, UPDATE, DELETE
        - IT 개발 표현 언어 (CRUD로 부른다.)
            - SELECT : Request
            - INSERT : Create
            - UPDATE : Update
            - Delete : Delete
            - EX. 이 프로그램은 CRUD 중에서 CRU로 개발하라! -> INSERT, UPDATE, SELECT를 할 수 있는 기능을 개발하라!

        - SELECT
            ```sql
             SELECT [ALL | DISTINCT] 속성이름(들)
               FROM 테이블명(들)
             [WHERE 검색조건(들)]
             [GROUP BY 속성이름(들)]
            [HAVING 검색조건(들)]
             [ORDER BY 속성이름(들) [ASC|DESC]]
            ```

## 2일차 (2024-03-29)
- Database 학습
    - DB 개발시 사용할 수 있는 툴
        - SSMS(기본)
        - Visual Studio - 아무런 설치 없이 개발 가능
        - Visual Studio Code - SQL Server(mssql) 플러그인 설치하고 개발
            - SQL 연결 탭에서 Add Connection 선택
            - Local host 입력
            - 데이터 베이스명 입력
            - id/비밀번호 입력
                - Save는 선택
            - enable
    - Hostname(ServerName) - 자신의 컴퓨터의 이름(cmd에서 hostname 을 통해 확인 가능/)|내 네트워크 주소|127.0.0.1(LoopBack IP)|localhost(LoopBack URL) 선호하는 아무거나
    - 관계 데이터 모델
        - 릴레이션 - 행과 열로 구성된 테이블
            - 행(튜플), 열(속성), 스키마, 인스턴스 용어 정리
            - 릴레이션의 특징
                - 1. 속성은 단일 값을 가진다.
                    - 책 이름이 여러개 들어가면 안된다.
                - 2. 속성은 서로 다른 이름을 가진다.
                    - '책 이름' 이라는 속성이 여러개 있으면 안된다.
                - 3. 한 속성의 값은 정의된 도메인 값을 가진다.
                    - 대학교 학년에 9학년이 있으면 안된다.
                - 4. 릴레이션 내의 중폭된 튜플은 허용하지 않는다.
                    - 같은 책 정보를 두 번 넣을 수 없다.
                - 5. 속성의 순서는 상관없다.
                - 6. 튜플의 순서는 상관없다.
                    - 1, 5, 3, 2, 7, 9, ...
        
        - 테이블(실제 DB) - 릴레이션과 매핑되는 이름
            - 행(레코드), 열(컬럼), 내포(필드명), 외연(데이터)
        - 차수(degree) : 속성의 수 
        - 카디널리티(cardinality) : 튜플의 수

        - 관계 데이터 모델은 아래의 요소로 구성된다.
            - 릴레이션(Relation)
            - 제약 조건(Contraints)
            - 관계 대수(Relational algebra)

        - 한번에 같은 문자 여러개를 지우는 경우
            - 지우고 싶은 문자를 드래그 후 Ctrl + H -> Ctrl + Alt + Enter

- DML 학습
    - SELECT 문
        - 복합 조건
            - ORDER BY
                - 정렬은 DB에서 진행하는게 가장 간편하고 이는 ORDER BY 구문을 통해 진행한다.
                - 정렬은 기본적으로 ASC(Ascending : 오름차순)이다.
                    - ASC  : (Ascending : 오름차순)
                    - DESC : (Descending : 내림차순)
                ```sql
                -- Q. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색
                 SELECT *
                   FROM Book
                  ORDER BY price ASC, bookname DESC;
                ```

        - 집계 함수와 GROUP BY, HAVING, WHERE
            - 집계 함수
                - SUM(총 합), AVG(평균), COUNT(개수), MIN(최소), MAX(최대) 
            - GROUP BY
                - GROUP BY절에 들어있는 컬럼 외에는 SELECT문에 절대 사용 할 수 없음
                ```sql
                 SELECT custid, bookid SUM(saleprice) AS '판매액' 
                   FROM Orders
                  GROUP BY custid;
                 -- bookid는 사용 불가
                ```
                - 단, saleprice는 집계함수 안에 들어있으므로 예외이다.
            - HAVING
                - HAVING은 집계함수의 필터로 GROUP BY 뒤에 작성. WHERE절과 필터링이 다르다.
                - 집계함수의 경우 조건에 HAVING을 사용.
                ```sql
                 SELECT custid, COUNT(*) AS [구매수]
                   FROM Orders
                  WHERE saleprice >= 8000
                  GROUP BY custid
                 HAVING COUNT(*) >= 2; -- 조건 : COUNT(2) 가 2 이상인 것
                ```
            - WHERE
                - WHERE 절에서 조건을 설정할 때 문자가 포함되는 경우 LIKE 를 사용한다.
                    - EX. 성이 '김'씨이고, '아'로 끝나는 이름인 고객의 이름과 주소
                    ```sql
                     SELECT [name]
                          , [address]
                       FROM Customer
                      WHERE [name] LIKE '김%아';
                    ```
            

        - 두 개 이상의 테이블 질의(Query)
            - 관계형 DB에서 가장 중요한 기법 중 하나이다. : JOIN
            ```sql
            -- Q. Customer, Orders 테이블을 동시에 조회하라(조건없이)
             SELECT *
               FROM Customer, Orders; 
            -- 50개 행이 출력, 그러나 이는 제대로 알아 볼 수 없는 의미없는 출력이다.
            -- 이는 조건이 제대로 달려있지 않기 때문이다
            
            -- Q. Customer, Orders 테이블을 동시에 조회하라(둘의 custid가 일치한다는 조건)
             SELECT *
               FROM Customer, Orders
              WHERE Customer.custid = Orders.custid -- Customer, Orders 둘의 custid가 일치한다는 의미의 WHERE 절
              ORDER BY Customer.custid ASC;
            -- 10개 행이 출력, 정확히 출력된다.

            -- 현재 단계에서는 출력되는 행이 Customer(행의 수) + Orders(행의 수) = 10행을 넘어설 수 없다. 
            ```

            - 실무
                - 실무에서는 *(ALL) 을 잘 사용하지 않기때문에
                ```sql
                 SELECT c.custid
                      , c.[name]
	                  , c.[address]
	                  , c.phone
	                  , o.orderid
	                  , o.custid
	                  , o.bookid
	                  , o.saleprice
	                  , o.orderdate
                   FROM Customer AS c, Orders AS o
                  WHERE c.custid = O.custid
                  ORDER BY C.custid ASC;
                ```
                - 이처럼 각 테이블의 별명으로 줄여 사용하는 것이 일반적이다.
                - 내부 조인, Inner Join
                    - 지금과 같이 양쪽의 수가 딱 일치하는 경우에 사용하는 Join을 의미한다.
            - Join
                - 관계형 DB에서 가장 중요한 기법 중 하나 : JOIN!
                - INNER JOIN(내부 조인)
                - LEFT|RIGHT OUTER JOIN(외부 조인) - 어느 테이블이 기준인지에 따라서 결과가 상이함
            ![외부 조인](https://raw.githubusercontent.com/c9yu/basic-database-2024/main/imamges/db004.png)
                - 참조 : https://sql-joins.leopard.in.ua/

## 3일차 (2024-04-01)
- Database 학습
    - 관계 데이터 모델
        - 키
            - 특정 튜플을 식별할 때 사용하는 속성 혹은 속성의 집합
            - 릴레이션 간에 관계를 맺는 데도 사용
            - 키가 되는 속성은 반드시 값이 달라서 튜플들을 서로 구별할 수 있어야 한다.
            
            - 슈퍼키 (단일, 집합)
                - 튜플을 유일하게 식별할 수 있는 값이면 모두 슈퍼키가 될 수 있다. (중복X)
                    - EX. 고객번호 : 고객별로 유일한 값이 부여되어 있기 때문에 튜플을 식별 가능
                    - EX. 이름 : 동명이인이 있을 경우 튜플을 유일하게 식별 할 수 없음
                    - EX. 고객번호, 이름
            
            - 후보키 (최소 집합(단일))
                - 튜플을 유일하게 식별할 수 있는 속성의 최소 집합 (중복X)
                    - EX. 고객번호, 주민번호

            - 복합키 (집합)
                - 두 개 이상의 속성의 집합으로 이루어진 키
                    - EX. 고객번호, 주민번호

            - *기본키(단일) - Pribary Key
                - 여러 후보키 중에서 하나를 선정하여 대표로 삼는 키
                    - 기본키 선정시 고려사항
                        - 릴레이션 내 튜플을 식별할 수 있는 고유한 값을 가져야 한다.
                        - NULL 불가능
                        - 최소 속성의 집합
                        - 개인정보등의 보안사항은 사용 자제
                    - EX. 고객번호           
            
            - 대리키(단일)
                - 기본키가 보안을 요하거나, 여러개의 속성으로 구성되어 복잡하거나, 마땅한 기본키가 없는 경우
                일련번호 같은 가상의 속성을 만들어 이를 대리키(혹은 인조키)로 사용한다.
                - EX. 고객번호 - 기본키이면서 대리키
            
            - 대체키
                - 기본키로 선정되지 않은 후보키

            - *외래키 - Foriegn Key
                - 기본키를 참조하여 사용하는 것
                - 고려사항
                    - 다른 릴레이션과의 관계
                    - 다른 릴레이션의 기본키를 호칭
                    - 서로 같은 값이 사용된다
                    - 기본키가 변경되면 외래키도 변경되어야 함
                    - 반드시 Not NULL은 아니다 (Not NULL인 경우도 있음)
                    - 중복을 허용한다
                    - 자기 자신의 기본키를 외래키로 사용할 수도 있음
                    - 외래키가 기본키의 속성 중 하나가 될 수도 있음

        - 무결성 제약조건
            - 데이터 무결성(Integrity) 
                - DB에 저장된 데이터의 일관성과 정확성을 지키는 것
            - 도메인 무결성 제약조건 
                - 릴레이션 내의 튜플들이 각 속성의 도메인에 지정된 값만을 가져야 한다는 조건 
                - 데이터 타입, NOT NULL, 기본값(무슨 값인지 모를땐 1을 넣어라 등), 체크 특성을 지키는 것
            - 개체 무결성 제약조건
                - '기본키 제약' 이라고 하기도 함
                - Unique에 NOT NULL (값이 중복되어도 안되고, 빠져도 안된다.)
            - 참조 무결성 제약조건
                - '외래키 제약' 이라고 하기도 함
                - 부모의 키가 아닌 값은 사용할 수 없다.
                - 외래키가 바뀔 때 기본키의 값이 아닌 것은 제약을 받는다. (사용할 수 없다)
                - RESTRICT (자식에서 키를 사용하고 있으면 부모 삭제 금지)
                - CASCADE (부모가 지워지면 해당 자식도 같이 삭제)
                - DEFAULT (부모가 지워지면 자식은 지정된 기본값으로 변경)
                - NULL (부모가 지워지면 자식의 해당값을 NULL로 변경)
            - 유일성 제약조건
                - 일반 속성의 값이 중복되면 안되는 제약조건. NULL값은 허용

- DML 학습
    - SELECT문
        - 외부 조인(OUTER JOIN)
            - LEFT OUTER JOIN
                - 왼쪽 테이블 기준으로 조건에 일치하지 않는 왼쪽 테이블 데이터 모두 표시
                ```sql
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
                ON c.custid = o.custid
                /*
                1~10행은 A와 B의 교집합에 해당하고 11행은 교집합을 제외한 A에 해당한다
                그로인해 11행의 B에 해당하는 값들이 전부 NULL이 출력된다.
                */
                ```
            - RIGHT OUTER JOIN
                - 오른쪽 테이블 기준으로 조건에 일치하지 않는 오른쪽 테이블 데이터 모두 표시

            - FULL OUTER JOIN
                - 잘 사용하지 않음 

        - 부속 질의(SubQuery)
            - 쿼리 내에 다시 쿼리를 작성하는 것
            - 서브쿼리를 쓸 수 있는 장소
                - SELECT 절
                    - 한 컬럼에 하나의 값만 사용
                    ```sql
                     SELECT o.orderid
                          , o.custid
                          , (SELECT name FROM Customer WHERE custid = o.custid) AS '고객명'
                          , o.bookid
                          , (SELECT bookname FROM Book WHERE bookid = o.bookid) AS '도서명'
                          , o.saleprice
                          , o.orderdate
                       FROM Orders AS o;
                    ```
                - FROM 절
                    - 가상의 테이블로 사용
                    ```sql
                     SELECT t.*
                       FROM (
                             SELECT b.bookid
                                  , b.bookname
                                  , b.publisher
                                  , o.orderdate
                                  , o.orderid
                               FROM Book AS b, Orders AS O
                              WHERE b.bookid = o.bookid
                            ) AS t;
                    ```
                - WHERE 절
                    - 여러 조건에 많이 사용
                    ```sql
                     SELECT [name] AS '고객 이름'
                       FROM Customer
                      WHERE Custid IN (SELECT DISTINCT custid 
                       FROM Orders); 
                    -- IN을 사용하면 구매한 적 있는사람
                    ```
        - 집합연산 - JOIN도 집합이지만, 속성별로 가로로 병합하기 때문에 집합이라 부르지 않음. 집합은 데이터를 세로로 합치는 것을 뜻함
            - 차집합 (EXCEPT, 거의 사용안함)
            - 합집합 (UNION, 진짜 많이 사용함)
            - 교집합 (INTERSECT, 거의 사용 안함)
            - EXISTS : 데이터 자체의 존재여부

    - DDL
        - CREATE : 개체(데이터베이스, 뷰, 테이블, 사용자 등)를 생성하는 구문
        ```sql
        -- 테이블 생성에 한정
        CREATE TABLE 테이블명
        ({ 속성이름 데이터타입
            [NOT NULL]
            [UNIQUE]
            [DEFAULT 기본값]
            [CHECK 체크조건]
        }
            [PRIMARY KEY 속성이름(들)]
            {[FORIEGN KEY 속성이름 REFERENCES 테이블이름(속성이름)]
                [ON UPDATE [NO ACTION | CASCADE | SET NULL | SET DEFAULT]]
            }
        )
        ```
    - ALTER : 개체를 변경(수정)하는 구문
        ```sql
        ALTER TABLE 테이블명
            [ADD 속성이름 데이터타입]
            [DROP COLUMN 속성이름]
            [ALTER COLUMN 속성이름 데이터타입]
            [ALTER COLUMN 속성이름 [NULL | NOT NULL]]
            [ADD PRIMARY KEY(속성이름)]
            [[ADD | DROP] 제약조건이름];
        ```
    - DROP : 개체를 삭제하는 구문
        ```sql
        DROP TABLE 테이블명;
        ```

        - 외래키로 사용되는 기본키가 있으면, 외래키를 사용하는 테이블 삭제 후, 기본키의 테이블을 삭제해야 함 - 중요!!

## 4일차(2024-04-02)
- 관계 데이터 모델
    - 관계대수(Relation Algebra) : 릴레이션에서 원하는 결과를 얻기 위한 수학의 대수와 같은 연산을 이용하여 기술하는 언어
        - 관계대수식
            - 릴레이션 간 연산을 통해 결과 릴레이션을 찾는 절차를 기술한 언어
            - 대상이 되는 릴레이션과 연산자로 구성되며, 결과는 릴레이션으로 반환됨. 반환된 릴레이션은 릴레이션의 모든 특징을 따름
            - 단항 연산자 : 연산자<조건> 릴레이션
            - 이항 연산자 : 릴레이션1 연산자<조건> 릴레이션2
        - 셀렉션, 프로젝션, 집합, 조인, 카티션 프로덕트, etc...

- DML 학습(SELECT 외)
    - INSERT
        - 테이블에 새로운 튜플을 삽입하는 명령어

        ```sql
        INSERT INTO 테이블이름[(속성리스트)]
            VALUES (값리스트);
        ```
    - UPDATE
        - 특정 속성값을 수정하는 명령어

        ```sql
        -- 트랜잭션을 걸어서 복구를 대비
        UPDATE 테이블이름
            SET 속성이름1 = 값[, 속성이름2 = 값, ...]
         WHERE <검색조건>   -- 실무에서는 빼면 큰일남
        ```
    - DELETE
        - 테이블에 있는 기존 튜플을 삭제함

        ```sql
        -- 트랜잭션을 걸어서 복구를 대비
        DELETE FROM 테이블이름
         WHERE 검색조건;    -- 실무에서는 빼면 큰일남
        ```

- SQL 고급
    - 내장함수
        - 수학함수, 문자열함수, 날짜/시간 함수, 변환함수, 커서 함수(!), 보안함수, 시스템함수
    - 서브쿼리 리뷰
        - SELECT - 단일행, 단일열(스칼라 서브쿼리)
        - FROM - 다수행, 다수열
        - WHERE - 다수행, 단일열(보통)
            - 비교연산, 집합연산, 한정연산, 존재연산 가능
    - NULL 값 처리
        - 집계함수의 NULL
            - 'NULL + 숫자' 연산의 결과는 NULL
            - 집계 함수 계산 시 NULL이 포함된 행은 집계에서 빠짐
            - 해당되는 행이 하나도 없을 경우 SUM, AVG 함수의 결과는 NULL이 되며, COUNT함수의 결과는 0이다.

## 5일차 (2024-04-03)
- SQL 고급
    - 서브쿼리 리뷰
    - 뷰
        - 장접
            - 편리성(및 재사용성)
                - 자주 사용되는 복잡한 질의를 뷰로 미리 정의해 놓을 수 있음. -> 복잡한 질의를 간단히 작성
                - 미리 정의된 뷰를 일반 테이블처럼 사용할 수 있기 때문에 편리함
            - 보안성
                - 각 사용자별로 필요한 데이터만 선별하여 보여줄 수 있음. 중요한 질의의 경우 질의내용을 암호화 할 수 있음 -> 개인정보(주민번호)나 급여, 건강 같은 민감한 정보를 제외한 테이블을 만들어 사용
            - 논리적 독립성 제공
                - 개념 스키마의 데이터베이스 구조가 변하여도 외부 스키마에 영향을 주지 않도록 하는 논리적 데이터 독립성 제공
        - 특징
        1. 원본 데이터 값에 따라 같이 변함
        2. 독립적인 인덱스 생성이 어려움
        3. CDU 연산(삽입, 삭제, 갱신 연산)에 많은 제약이 따름
         
        ```sql
        -- 생성
        CREATE VIEW 뷰이름[(열이름 [, ...])]
        AS <SELECT 쿼리문>;        
        ```

        ```sql
        -- 삭제
        DROP VIEW 뷰이름;
        ```

        - 알아두면 유용한 코드
            - 내 데이터베이스에 있는 db종류 조회 코드
            ```sql
            SELECT * FROM sys.databases;
            ```
            - 테이블 내에 존재하는 컬럼명 조회 코드
            ```sql
            SELECT * FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = 'Book';
            ```

    - 인덱스
        - 인덱스는 테이블에서 한 개 이상의 속성을 이용하여 생성함.
        - 빠른 검색과 함께 효율적인 레코드 접근이 가능함.
        - 순서대로 정렬된 속성과 데이터의 위치만 보유하므로 테이블보다 작은 공간을 차지함.
        - 저장된 값들은 테이블의 부분집합이 됨.
        - 일반적으로 B-tree 형태의 구조를 가짐
        - 데이터의 수정, 삭제 등의 변경이 발생하면 인덱스의 재구성이 필요함.
        - pk에 거는건 클러스터형, 그 외는 비클러스터형
    ```sql
    -- 생성
    CREATE [UNIQUE] [CLUSTERED|NONCLUSTERED] INDEX 인덱스이름
    ON 테이블명 (속성이름 [ASC|DESC] [,...n]);

    -- 수정
    ALTER INDEX {인덱스 이름|ALL}
    ON 테이블명 { REBUILD | DISABLE | REORGANIZE };

    -- 삭제
    DROP INDEX 인덱스이름 ON 테이블명;

    /*
     인덱스를 사용할 경우 테이블 전체를 검색하는 것이 아닌 인덱스 검색한다.
     데이터가 적은 경우에는 티가 나지 않지만 매우 많은 경우에 효과적이다.
    */
    ```

    - 파이썬 SQL Server 연동 프로그래밍
        - Madang DB 관리 프로그램
            - PyQT GUI 생성
            - SQL Server 데이터 핸들링
                - pymssql 라이브러리 설치

                ```shell
                > pip install pymssql
                ```
            - DB 연결 설정 - Oracle, MySQL 등은 설정이 없음. 구성관리자에서 TCP/IP로 접근을 허용하지 않으면 접속 안됨
                - 1.시작메뉴 > 모든앱 > Microsoft SQL Server 20xx > **SQL Server 20xx 구성관리자** 실행
                - 2.SQL Server 네트워크 구성 > **MSSQL SERVER에 대한 프로토콜** 클릭
                - 3.TCP/IP 프로토콜 상태가 사용 안함(최초) > TCP/IP를 더블클릭
                - 4.**프로토콜 사용을 > '예'**로 변경
                - 5.IP주소 탭 > IP주소가 **본인 IP인 것에 사용을 > '예'**로 변경
                - 6.**127.0.0.1로 된 주소 > 사용 > '예'**로 변경
                - 7.적용 후 SQL Server 서비스 > SQL Server(MSSQLSERVER) 더블클릭 후, **다시 시작** 버튼 클릭, 재시작 필요(!)


            ![구성관리자](https://raw.githubusercontent.com/c9yu/basic-database-2024/main/imamges/db005.png)
            

    - 데이터베이스 모델링

## 6일차 (2024-04-04)
- 파이썬 SQL Server 연동 프로그래밍
    - Madang DB 관리 프로그램
        - PyQt5 + pymssql

    - 탭순서 편집
    - 프로그램을 작성하며 생긴 문제점
        - 한글 깨짐 문제
            - 1.DB 테이블을 우클릭 -> 디자인탭에서 varchar(ASCII) -> nvarchar(UTF-8)로 변경
            - 2.Python에서 pymssql로 접속할 때, Charset을 utf-8로 설정
            - 3.INSERT 쿼리에 한글 입력되는 컬럼은 N''을 붙여준다.

    - 실행화면

    https://github.com/c9yu/basic-database-2024/assets/158007438/6eead07a-1005-4155-acbf-2d191fff4501


    


## 7일차
- SQL 고급
    - 트랜잭션
        - DBMS에서 데이터를 다루는 논리적인 작업의 단위
        - All or Nothing
            - 트랜잭션은 전체가 수행되거나 또는 전혀 수행되지 않아야 한다.

        - 데이터베이스에서 트랜잭션을 정의하는 이유
            - 데이터베이스에서 데이터를 다룰 때 장애가 일어날 때 데이터를 복구하는 작업의 단위가 됨
            - 데이터베이스에서 여러 작업이 동시에 같은 데이터를 다룰 때 작업을 서로 분리하는 단위가 됨
                - EX. 트랜잭션이 정의되지 않은 경우
                    - 하나의 계좌(50,000원)에 두 개의 체크카드를 사용한다고 했을때, 두 카드로 동시에 인출(10,000, 20,000원)을 진행할 경우 20,000원이 남는 것이 아닌, 30,000원이 남아버린다. 

        - 트랜잭션의 ACID 성질
            - 원자성 (Atomicity)
                - 트랜잭션에 포함된 작업은 전부 수행되거나 아니면 전부 수행되지 않아야(all or nothing) 함.
            - 일관성 (Consistency)
                - 트랜잭션을 수행하기 전이나 수행한 후에 데이터베이스는 항상 일관된 상태를 유지해야 함.
            - 고립성 (Isolation)
                - 수행 중인 트랜잭션에 다른 트랜잭션이 끼어들어 변경 중인 데이터 값을 훼손하는 일이 없어야 함.
            - 지속성 (Durability)
                - 수행을 성공적으로 완료한 트랜잭션은 변경한 데이터를 영구히 저장해야 함.

        - TCL (Transaction Control Language)
            - TCL에서 사용할 키워드
                - BEGIN, TRAN[SACTION], COMMIT, ROLLBACK, SAVE

    - SQL Server는 기본적으로 Auto Commit(시스템이 자동적으로 트랜잭션을 건다.)
    - SSMS > 도구 > 옵션 > 쿼리 실행 > SQL Server > ANSI
        -> SET IMPLICIT_TRANSACTIONS 체크, 프로그램 재시작

    - 락 : 로직 처리시 다른 트랜잭션의 간섭을 받지 않기 위한 것
        - 중요한 데이터 수정, 삭제시 잘못된 변경을 방지하기 위한 것

- 데이터베이스 모델링
    - 설계 순서 : 개념 설계 -> 논리 설계 -> 물리적 설계
    - 개념적 모델링
        - 요구사항을 받으면서 정해지지 않은 여러 개체들을 정립화 하는 단계
        - 요구사항을 수집하고, 분석한 결과를 토대로 업무의 핵심적인 개념을 구분하고 전체적인 뼈대를 만드는 과정

    - 논리적 모델링
        - 기본키 지정, 외래키 지정, 관계 정립, 속성들 이름(한글) 개체를 정하는 단계
        - 개념적 모델링에서 만든 ER 다이어그램을 사용하라는 DBMS에 맞게 사상(매핑, mapping)하여 실제 데이터베이스로 구현하기 위한 모델을 만드는 과정
        - 논리적 모델링 과정
            - 개념적 모델링에서 추출하지 않았던 상세 속성들을 모두 추출함
            - 정규화 수행
            - 데이터 표준화 수행

    - 물리적 모델링
        - DB에 맞춰서 컬럼이름, 컬럼 데이터 타입 및 크기 지정, DB에 대한 검토로 테이블을 만들기 직전의 설계를 완성
        - 작성된 논리적 모델을 실제 컴퓨터의 저장 장치에 저장하기 위한 물리적 구조를 정의하고 구현하는 과정
        - DBMS의 특성에 맞게 저장 구조를 정의해야 데이터베이스가 최적의 성능을 낼 수 있음.

    - ER 모델링 : ERD를 그리기 위한 기본 이론

    - 차수에 따른 관계 타입의 유형
        - 일대일 관계
        - 일대다/다대일 관계
        - 다대다 관계 : 이 복합적 관계가 DB 설계시 가장 문제가 된다.
    
    ![ER 표기법](https://raw.githubusercontent.com/c9yu/basic-database-2024/main/imamges/db007.png)

    도서, 고객과 같은 명사의 경우 '네모', 주문과 같은 동사는 '마름모' 형태로 표현된다.

    - IE 표기법

    ![IE 표기법](https://raw.githubusercontent.com/c9yu/basic-database-2024/main/imamges/db008.png)

    실무에서는 ER 표기법 보다는 IE 표기법을 더 많이 사용한다.

    - ERwin 실습
    - 물리적인 데이터베이스에서 다대다는 구현할 수 없다.
        - 그렇기에 풀어서 구현해야 함

    - 인덱스 예제
        - PK나 인덱스가 없는 상태에서 성능문제 체크
        - 인덱스가 설정되면 성능이 어떤지 비교
        

## 8일차

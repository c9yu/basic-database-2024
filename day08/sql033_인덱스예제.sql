-- 지난 시간에 잘못 만든 데이터를 전부 초기화
-- 삭제
DELETE FROM Users; -- WHERE 절이 없으면 모두 삭제

-- 단, identity(1,1)로 설정한 테이블에서 1부터 다시 넣도록 설정하려면
TRUNCATE TABLE Users; -- 모두 지우고 테이블 초기화까지 함.

-- 200만건으로 줄여서 다시 시작
DECLARE @i INT;
SET @i = 0;

WHILE (@i < 2000000) -- 200만건
    BEGIN
        SET @i = @i + 1;
        INSERT INTO Users (username, guildno, regdate)
        VALUES (CONCAT('user',@i), @i/100, DATEADD(dd, -@i/100,GETDATE()));
    END;

-- 인덱스가 없는 상태
-- 100만건 정도 데이터 조회시 5~8초 사이의 시간 소요

-- 인덱스를 걸기 위해서 userid에 기본키(PK)를 설정
ALTER TABLE Users ADD PRIMARY KEY(userid);
-- 기본키(PK)에는 무조건 클러스터드 인덱스가 걸린다.

-- ! WHERE에 검색을 위해서 username을 사용함
-- 인덱스를 PK에 거는 게 아니라 username
Create CLUSTERED INDEX IX_Users_username ON Users(username);

DROP INDEX IX_Users_username ON Users;

-- 인덱스는 대량의 데이터에서 찾고자 하는 데이터를 빠르게 찾게 해주는 목적
-- WHERE절, JOIN의 ON절에 들어가는 컬럼에 인덱스를 설정하는 것이 속도 개선에 도움
-- 1번 PK, 2번 FK, 3번 WHERE절에 검색시 들어가는 컬럼에 인덱스를 설정
-- 단, NULL값이 많거나, 중복이 많은 컬럼에 인덱스를 걸면 성능에 도움을 받지 못한다.
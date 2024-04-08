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
# basic-database-2024
IoT 개발자 과정 SQLServer 학습 리포지토리

## 1일차
- MS SQL Server 설치: https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads 최신버전 설치
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

    - 개발툴 설치
        - SSMS(Sql Server Management Studio) DB에 접근하여 여러 개발작업을 가능하게 하는 툴
        - 링크: https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16 한국어 버전 클릭하여 설치
            - 다운로드 된 파일을 열고 별도의 지정 없이 설치 하면 된다.
        
    - 데이터베이스 개념
        - 데이터를 보관, 관리, 서비스하는 시스템
        - Data, Information, Knowledge 개념
        - DBMS > Database > Data(Model)

    - DB 언어
        - SQL(Structured Query Language) : 구조화 된 질의 언어
            - DDL (Data Definition Language) : 데이터베이스, 테이블, 인덱스 생성 기능
            - DML (Data Manipulation Language) : 검색, 삽입, 수정, 삭제 기능 (!)
            - DCL (Data Control Language) : 권한, 트랜스액션(트랜잭션) 부여/제거 기능

    - 접속
        - SQL Server Management studio 접속
            - 인증 : SQL Server 인증으로 선택
                - 미리 지정해뒀던 패스워드 입력
            - 암호화 : 선택적
            - 이후 연결 클릭

    - 설정
        - 도구 -> 옵션
            - 텍스트 편집기 : 모든 언어 줄번호 체크
            - 디자이너 : NULL 기본키 경고 체크, 테이블을 다시 만들어야 하는 변경 내용 저장 안함 체크해제
            - SQL Server 개체 탐색기 : 테이블 및 뷰 옵션 탭의 상위 n개 행 선택/편집 명령의 값 0으로 지정
## 2일차


## 3일차


## 4일차
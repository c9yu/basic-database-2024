# 파이썬 DB 연동 프로그램

import sys
from PyQt5 import uic
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import *
from PyQt5.QtGui import QCloseEvent
from PyQt5.QtGui import *
import webbrowser
from PyQt5.QtWidgets import QWidget

# MSSQL 
import pymssql as db

# 전역변수 (이후 변경시 여기만 변경하면 되니까)
serverName = '127.0.0.1'
userId = 'sa'
userPass = 'mssql_p@ss'
dbName = 'Madang'
dbCharset = 'UTF8' # EUC-KR 사용 X

# 저장버튼 클릭시 삽입, 수정을 구분짓기 위한 구분자
mode = 'I' # I or U,  I: Insert, U: Update

class qtApp(QMainWindow):
    def __init__(self) -> None:
        super().__init__()
        uic.loadUi('./day06./MadangBook.ui',self) # 나에게 ui를 던져줘라
        self.initUI()


    #def initUI(self) -> None:
    #    self.show()
        
    def initUI(self)->None:
        # 숫자만 입력
        self.txtBookId.setValidator(QIntValidator(self))
        self.txtPrice.setValidator(QIntValidator(self))

        # 버튼 4개에 대해서 사용 등록
        self.btnNew.clicked.connect(self.btnNewClicked) # 신규버튼 시그널(이벤트)에 대한 슬롯함수 생성
        self.btnSave.clicked.connect(self.btnSaveClicked) # 저장 버튼
        self.btnDel.clicked.connect(self.btnDelClicked) # 삭제 버튼
        self.btnReload.clicked.connect(self.btnReloadClicked) # 조회 버튼
        self.tblBooks.itemSelectionChanged.connect(self.tblBooksSelected) # 테이블위젯 결과를 클릭시 발생
        self.show()

        self.btnReloadClicked() # 프로그램 키자마자 조회가 되도록 한다.

    def btnNewClicked(self): # 신규버튼 클릭
        global mode ## 전역변수 사용 변경
        mode = 'I'

        # 신규 버튼을 눌렸을 때 기존에 있던 셋박스의 글자들을 없애주는 형태
        self.txtBookId.setText('') 
        self.txtBookName.setText('')
        self.txtPublisher.setText('')
        self.txtPrice.setText('')
        
        # 선택한 데이터에서 신규를 누르면 self.txtBooId 사용여부는 변경해줘야 한다
        self.txtBookId.setEnabled(True) # 사용

        # TODO : TODO는 이후에 작업할 부분을 체크해 둘 때 사용하는 것으로 Ctrl + F 로 찾아서 이후에 처리한다

    def btnSaveClicked(self): # 저장버튼 클릭
        # 입력 검증(Validation Check) 반드시 해야한다. - 기본키는 유일해야 하는데, 사용자가 id에 이미 있는 1을 또 집어 넣으면 안되기 때문

        # 1. 텍스트박스를 비워두고 저장버튼 누르면 안된다.
        bookid = self.txtBookId.text()
        bookname = self.txtBookName.text()
        publisher = self.txtPublisher.text()
        price = self.txtPrice.text()

        print(bookid, bookname, publisher, price)
        warningMsg = '' # 경고 메시지
        isValid = True # 빈 값이 있으면 False로 변경
        if bookid == None or bookid == '':
            warningMsg += '책 번호가 없습니다.\n'
            isValid = False
        if bookname == None or bookname == '':
            warningMsg += '책 제목이 없습니다.\n'
            isValid = False
        if publisher == None or publisher == '':
            warningMsg += '출판사가 없습니다.\n'
            isValid = False
        if price == None or price == '':
            warningMsg += '정가가 없습니다.\n'
            isValid = False     

        if isValid == False: # 위 입력값중에 하나라도 빈값이 존재
            QMessageBox.warning(self, '저장 경고', warningMsg)       
            return

        ## Mode가 'I'일 때는 중복번호를 체크 및 들여쓰기해야 하지만, mode = 'U'일때는 중복번호를 체크해서 막으면 수정자체가 안된다.
        if mode == 'I': # Insert 경우

            # 2. 현재 존재하는 번호와 같은 번호를 사용했는지 체크 만약 이미 있는 번호면 DB 입력 쿼리가 실행되지 않도록 막는다.
            conn = db.connect(server = serverName, user = userId, password = userPass, database = dbName, charset = dbCharset)
            cursor = conn.cursor(as_dict = False) # COUNT(*)는 데이터가 딱 1개이기 때문에 as_dict = False로 해야함
            
            query = f'''SELECT COUNT(*)
                        FROM Book
                        WHERE bookid = {bookid}''' 
            cursor.execute(query)
            #print(cursor.fetchone()[0]) # COUNT(*)는 데이터가 딱 1개이기 때문에 cursor.fetchone() 함수로 (1, ) 튜플을 가져옴
            valid = cursor.fetchone()[0]

            if valid == 1: # DB Book 테이블에 같은 Id가 이미 존재
                QMessageBox.warning(self, '저장경고', '같은 번호의 데이터가 존재합니다!\n번호를 변경하세요.')
                return # 함수 탈출
            
        # 3. 입력검증 후 DB Book테이블에 저장
        # bookid, bookname, publisher, price
        if mode == 'I':
            query = f'''INSERT INTO Book
                        VALUES ({bookid}, N'{bookname}', N'{publisher}', {price})'''
        elif mode == 'U':
            query = f'''
                     UPDATE Book
                        SET bookname = N'{bookname}'
                          , publisher = N'{publisher}'
	                      , price = {price}
                      WHERE bookid = {bookid};
                     '''
            print(query) ### 오류가 발생하는 부분에 print(query)를 통해 어떤 값이 들어가 문제가 발생했는지확인 할 수 있다.

        conn = db.connect(server = serverName, user = userId, password = userPass, database = dbName, charset = dbCharset)
        cursor = conn.cursor(as_dict = False) # INSERT는 데이터를 가져오는 것이 아니라서 False를 사용한다.

        try:
            cursor.execute(query)
            conn.commit() # 저장을 확립
            if mode == 'I':
                QMessageBox.about(self, '저장성공', '데이터를 저장했습니다.')
            else :
                QMessageBox.about(self, '수정성공', '데이터를 수정했습니다.')
        except Exception as e:
            QMessageBox.warning(self, '저장실패', f'{e}')
            conn.rollback() # 원상복귀
        finally:
            conn.close() # 오류가 나든 안나든 DB는 닫는다.
        
        self.btnReloadClicked() # 조회버튼 클릭 함수만 실행하면 새로 데이터를 추가하고 자동으로 조회된다.

    def btnDelClicked(self): # 삭제버튼 클릭
        #QMessageBox.about(self, '버튼', '삭제버튼이 클릭됨')
        
        # 삭제 기능
        bookid = self.txtBookId.text()
        # print(bookid)
        # Validation Check 필요

        if bookid == None or bookid == '':
            QMessageBox.warning(self, '삭제경고', '책 번호 없이 삭제할 수 없습니다.')
            return
        
        # 삭제시 삭제여부 되묻기
        re = QMessageBox.question(self, '삭제여부', '정말로 삭제하시겠습니까?', QMessageBox.Yes | QMessageBox.No)
        if re == QMessageBox.No:
            return
        

        conn = db.connect(server=serverName, user = userId, password = userPass, database = dbName, charset = dbCharset)
        cursor = conn.cursor(as_dict=False) # INSERT는 데이터를 가져오는게 아니라서 FALSE
        query = f'''DELETE FROM Book
                     WHERE bookid = {bookid}'''
        
        try:
            cursor.execute(query)
            conn.commit()

            QMessageBox.about(self, '삭제성공', '데이터를 삭제했습니다.')
        except Exception as e:
            QMessageBox.warning(self, '삭제실패', f'{e}')
            conn.rollback()
        finally:
            conn.close()

        self.btnReloadClicked()

    def btnReloadClicked(self): # 조회버튼 클릭
        lstResult = []
        #QMessageBox.about(self, '버튼', '조회버튼이 클릭됨')
        conn = db.connect(server = serverName, user = userId, password = userPass, database = dbName, charset = dbCharset)
        cursor = conn. cursor(as_dict=True)

        query = '''
                SELECT bookid
                     , bookname
                     , publisher
                     , ISNULL(FORMAT(price, '#,#'), '0')AS price
                  FROM Book
                '''

        cursor.execute(query)
        for row in cursor:
            # print(f'bookid={row["bookid"]}, bookname={row["bookname"]}, publisher={row["publisher"]}, price={row["price"]}')
            # dictionary로 만든 결과를 lstResult에 append()
            temp = {'bookid' : row["bookid"], 'bookname' : row["bookname"], 'publisher':row["publisher"], 'price':row["price"]}
            lstResult.append(temp)

        conn.close() # DB는 접속해서 일이 끝나면 무조건 닫아줘야 한다.

        #print(lstResult) # tblBooks 테이블위젯에 표시
        self.makeTable(lstResult)

    def makeTable(self, data): # tblBooks 위젯에 데이터와 컬럼을 생성해주는 함수
        self.tblBooks.setColumnCount(4) # bookid, bookname, publisher, price 4개
        self.tblBooks.setRowCount(len(data))
        self.tblBooks.setHorizontalHeaderLabels(['책 번호', '책 제목', '출판사', '정가']) # 컬럼이 설정

        n = 0
        for item in data:
            print(item)
            # self.tblBooks.setItem(n, 0, QTableWidgetItem(str(item['bookid']))) # set(row, column, str type text)
            idItem = QTableWidgetItem(str(item['bookid']))
            idItem.setTextAlignment(Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter)
            self.tblBooks.setItem(n, 0, idItem)

            self.tblBooks.setItem(n, 1, QTableWidgetItem(item['bookname'])) # set(row, column, str type text)
            self.tblBooks.setItem(n, 2, QTableWidgetItem(item['publisher'])) # set(row, column, str type text)
            
            #self.tblBooks.setItem(n, 3, QTableWidgetItem(str(item['price']))) # set(row, column, str type text)
            priceItem = QTableWidgetItem(str(item['price']))
            priceItem.setTextAlignment(Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter)
            self.tblBooks.setItem(n, 3, priceItem)

            n += 1

        self.tblBooks.setColumnWidth(0, 65)  # 책번호 컬럼 넓이
        self.tblBooks.setColumnWidth(1, 230) # 책이름 컬럼 넓이
        self.tblBooks.setColumnWidth(2, 130) # 출판사 컬럼 넓이
        self.tblBooks.setColumnWidth(3, 80)  # 가격 컬럼 넓이

        # 컬럼 더블클릭 금지시키기 : 사용자가 데이터를 임의로 수정하는 것을 막기 위함
        self.tblBooks.setEditTriggers(QAbstractItemView.NoEditTriggers) # EditTriggers : 더블클릭
    
    def tblBooksSelected(self): # 조회결과 테이블위젯 내용 클릭
        rowIndex = self.tblBooks.currentRow() # 책 번호

        bookId = self.tblBooks.item(rowIndex, 0).text() # 책 번호
        bookName = self.tblBooks.item(rowIndex, 1).text() # 책 제목
        publisher = self.tblBooks.item(rowIndex, 2).text() # 출판사
        price = self.tblBooks.item(rowIndex, 3).text().replace(',', '')# : 터미널에 출력될 때 금액 부분의 쉼표를 없애주는 역할
        print(bookId, bookName, publisher, price)
        # 지정된 lineEdit(TextBox)에 각각 할당
        self.txtBookId.setText(bookId)  # txtBookId라는 이름의 셋박스에
        self.txtBookName.setText(bookName)
        self.txtPublisher.setText(publisher)
        self.txtPrice.setText(price)

        # 모드를 Update로 변경
        global mode # 전역변수를 내부에서 사용하는 경우
        mode = 'U'

        # txtBookId를 사용하지 못하게 설정 -- BookId는 기본키이므로 사용자가 건드려서는 안된다.
        self.txtBookId.setEnabled(False)

        



# 원래 PyQt에 있는 함수 closeEvent를 재정의(override)
    def closeEvent(self, event)->None:
        re = QMessageBox.question(self, '종료 여부', '종료하시겠습니까?', QMessageBox.Yes | QMessageBox.No)
        if re == QMessageBox.Yes:
            event.accept() # Yes 누르면 완전히 꺼짐
        else:
            event.ignore() # No 누르면 안꺼짐

if __name__ == '__main__':
    app = QApplication(sys.argv)
    inst = qtApp()
    sys.exit(app.exec_())
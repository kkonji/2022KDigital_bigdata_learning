# program: AddressBook
# DESCRIPTION: File I/O 처리, str 데이터 처리, function
# (1) AddressBook 폴더에 개인 파일 생성 -> 이름_전화번호.txt
# (2) 전체보기, 검색, 추가, 종료 기능 -> 메뉴 출력
# (3) 종료 입력 전까지 무한 반복
# 전역변수 및 상수 선언
DIR_PATH = './AddressBook/'  # 파일 저장 폴더
ADDR_LIST = []  # 주소 파일 저장

# 함수 정의
# 메뉴 출력 함수
# 함수명: displayMenu
# 파라미터: 없음
# 리턴값: 없음
def displayMenu():
    print("="*7 +'ADDRESSBOOK' + '='*7)
    print('1. 전체보기')
    print('2. 검   색')
    print('3. 추   가')
    print('4. 종   료')
    print('='*25)
# 전체 전화번호 리스트 출력 함수
# 함수명: showAddress
# 파라미터: 없음
# 리턴값: 없음
def showAddress():
    print('현재 등록된 주소록 정보')
    for addr in ADDR_LIST:
        print(addr)
# 등록된 주소 검색 후 정보 출력 함수
# 함수명: searchAddress
# 파라미터: name or phone_number str
# 리턴값: 없음
def searchAddress(word):
    # 파일명 리스트 안에서 해당 검색어 존재 여부 체크
    for add in ADDR_LIST:
        if name_phone in add:
            print(f'파일명: {add}')
            with open(DIR_PATH+ add+ '.txt',mode='r', encoding='utf-8') as f:
                print(f.read())
# 주소록 파일 생성 및 추가 함수
# 함수명: addAddress
# 파라미터: 이름, 전화번호, 지역, 이메일
# 반환값: 없음
def addAddress(name, phone, loc, email):
    filename = name + '_' + phone +'.txt'
    # 파일명 리스트 추가
    ADDR_LIST.append(filename[:-4])
    # AddressBook 폴더에 파일 생성
    with open(DIR_PATH+filename, mode='w', encoding='utf-8') as f:
        f.write(name + ' ' + phone + ' '+ loc + ' ' + email)




# 기능 구현

print('프로그램 시작!')
while True:
    displayMenu()
    # 사용자로부터 메뉴 선택 받기
    select = input("메뉴 선택: ")
    if select == '4': break
    elif select == '1':
        showAddress()
    elif select == '2':
        search = input('이름 또는 전화번호 검색: ')
        searchAddress(search)
    elif select == '3':
        name, phone, loc, email = input('이름, 전화번호, 지역, 이메일: (예시 홍길동, 010-1234-5678, 대구, aaa1123@gmail.com)').split(',')
        addAddress(name, phone, loc, email)
    else:
        print("해당 메뉴는 존재하지 않습니다.")
print('프로그램 종료!')

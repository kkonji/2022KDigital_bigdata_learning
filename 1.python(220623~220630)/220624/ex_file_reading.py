# 파일 읽고 쓰기 -> 파일 입출력 (I/O)
filename = 'mydata.txt'

# 파일 쓰기
# (1) 파일 열기
# mode 'w' -> 파일 없으면 생성 후 쓰기
#          -> 파일 있으면 내용 지우기 쓰기
# file = open(filename, mode='w', encoding='utf-8')
# mode 'a' -> 파일 없으면 생성 후 쓰기
#          -> 파일 있으면 덧붙이기
file = open(filename, mode='a', encoding='utf-8')
# (2) 파일에 데이터 쓰기
file.write('Good\n')
file.write('happy\n')

# (3) 파일 닫기
file.close()

# 파일 읽기
# mode 'r' -> read 약자, 기본값
# (1) 파일 열기
file = open(filename, mode='r')
# (2) 파일 읽기  (파일 전체 데이터 가져오기)
data = file.read() # 커서가 첫번째 자리에 있다가 read를 하면 마지막 자리에 있게 되기 때문에 두번째로 read하면 아무것도 안 읽힌다.
print(data)
file.seek(0) # 커서를 첫번째 자리로 넣는 함수
data2 = file.read()
print(len(data2))

# 파일 포인트 제일 앞으로
file.seek(0)
# 파일에서 한 줄 읽기 ('줄바꿈' 문자까지를 '한 줄'이라 한다.)
data3 = file.readline()
print(data3)
# 파일에서 한 줄씩 읽어서 리스트에 담아서 가져오기
data4 = file.readlines()
print(data4)
file.seek(0)
# 파일에서 원하는 길이만큼만 읽기
data5 = file.read(2)
print(data5)
# (3) 파일 닫기
file.close()


# 파일 경로 설정
f = open('C:\\Users\\User\\Desktop\\새파일.txt', mode='w')
f.close()

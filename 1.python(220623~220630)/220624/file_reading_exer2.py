# 파일 경로 설정
f = open('C:\\Users\\User\\Desktop\\새파일.txt', mode='w')
f.close()

# PATH -> 경로
# 절대경로 : 파일 및 폴더 존재하는 위치의 경로 C:\\Users\\User\\Desktop\\
# 상대경로 : 현재 코드 파일 기준으로 경로를 지정
# . : 현재 위치
# .. : 상위 한단계 위

# file = '../DATA/HOME.html'
# file = './HTML/HOME.html'

# home.html 파일을 라인 단위로 읽어서 화면에 출력하기
file = open('../DATA/HOME.html', mode='r', encoding='utf-8')
while True:
    line = file.readline()
    if not line: break
    line = line.strip()
    if len(line) > 0: print(line)
file.close()

# (중요) 경로에 r'./HTML/HOME.html' 달면 이스케이프 문자가 안 뜨고 str으로 바로 불러올 수 있다.

# file.tell() -> 파일 위치 읽기
# file.mode(), file.name()

# with ~ as 구문 -> close() 자동으로 처리됨
with open(filename, mode='r', encoding='utf-8') as file:
    while True:
        line = file.readline()
        if not line: break
        line = line.strip()
        if len(line) > 0: print(line)



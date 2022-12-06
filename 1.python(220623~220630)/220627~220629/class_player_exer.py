# 벽돌깨기 프로그램 만들기 (class 연습)

class player:
    # 변수: 닉네임, 단계, 점수, 순위
    # player 정보 저장: DB/ File
    def __init__(self, nickname, level = 0, score = 0, ranking = 0):
        self.nickname = nickname
        self.level = level
        self.score = score
        self.ranking = ranking
    # 클래스의 인스턴스 변수들의 값을 업데이트 또는 읽기 하는 메서드
    # set 메서드(값을 넣어주는) - get 메서드(값을 읽어오는)
    def setLv(self, level):
        self.level = level
    def setScore(self, score):
        self.score = score
    def setRank(self, r):
        self.ranking = r
    def getNickName(self):
        return self.nickname
    def getLv(self):
        return self.level
    def getScore(self):
        return self.score
    def getRank(self):
        return self.ranking

p1 = player("ㄹ")
print(type(p1) ==player)
player1 = None
player2 = None
# 게임하는 사람의 정보 입력 받기
def setPlayer():
    global player1, player2
    nickname = input("닉네임: ")
    if player1 == None:
        player1 = player(nickname)
    else:
        player2 = player(nickname)

def displayMenu():
    print('1.회원가입: ')
    print('2.게임시작: ')
    print('3.랭킹보기: ')
    print('4.종료')


# 프로그램 코드
while True:
    displayMenu()
    select = input("메뉴선택: ")
    if select == '4': break
    # 파일에 기록하고 종료
    elif select == '1':
        pass
    elif select == '2':
        pass

# 변수의 스코프(Scope)
# 지역변수: 함수에서만 사용, 파라미터, 함수안의 변수들
# 전역변수: 파이썬 파일에만 있는 변수, 같은 파이썬 파일 안에 있는 함수에서 사용가능

isgame = False
print(isgame)
def startgame():
    global isgame
    isgame = True
startgame()
print(isgame)
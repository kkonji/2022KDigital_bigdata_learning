# 배웠던 내용 연습

import os
# FILENAME = './YANG.txt'

# for i in range(10):
#     os.mkdir(f'./NAME{i}/')

 # 경로 뒤에 / 붙이든 안붙이든 상관없다.

# with open(FILENAME, mode="w", encoding='utf-8') as f:
#     f.write('a')
# os.mkdir(DIC_NAME)

# 파이썬에서 미리 만들어서 제공하는 클래스: int, float, bool, str, list, tuple, dict, set
# num = int(45)  # 실제로는 int() 생성자 실행
# print(num)

# 여러 종류의 데이터를 저장하는 데이터 타입
# 여러 개의 데이터를 가지고 다양한 작업 기능
# -------------------------------------------------
# 내가 만드는 클래스 -> 평면의 좌표값을 저장하는 데이터
# 클래스명: Point
# 속성, 특징, 변수: x, y
# 역할, 기능, 함수: Point 클래스로 메모리에 존재하는 객체(인스턴스) 생성하는 메서드 __init__(self,x,y)
# 객체(인스턴스)에 값을 읽어주는 메서드 -> get속성명() -> 현재속성값 반환bb
# 객체(인스턴스)에 값을 변경해주는 메서드 -> set속성명(새로운값)
# 내가 원하는 기능
class Point:              # 내부적으로 쓰는 클래스는 앞에 _를 붙인다.
    # Point 인스턴스를 생성하는 메서드
    def __init__(self,x=0,y=0):
        self.__x = x          # (_ 또는) __로 표시하면 x속성을 숨긴다. -> 3.9는 __
        self.y = y
    def setX(self, x):   self.__x = x  # setter 메서드

    # def setY(self, y): self.y = y
    #
    # def setXY(self, x, y):
    #     self.x = x
    #     self.y = y
    def getPoint(self): return self.__x, self.y  # getter 메서드

    # Point 인스턴스의 정보 출력하는 메서드
    def showPoint(self):
        print(f'현재 좌표값: {self.__x}, {self.y}')

    # Point 인스턴스에 해당하는 좌표를 그리는 메서드
    # x값 -> 가로로 이동, y값 -> 세로로 이동
    def drawPoint(self):
        if self.y >0: print("|\n"*self.y, end='')
        print('ㅡ'*self.__x + '♬', end='')



# Point 인스턴스(객체) 생성하기  , 필드(field) = 속성(attribute) = 변수
p1 = Point(9,2)
print(p1.getPoint())
p1.showPoint()
p1.drawPoint()
# p1.setX(5)
# print(p1.getPoint())
# p1.x = 1000   # 일반적인 객체지향 언어는 이렇게 이동하는걸 불허한다.
# print(p1.getPoint())

points = [Point(10,10), Point(5,5), Point(4,3), Point(0,0)]
# for i in points:
#     i.drawPoint()


# 상속: 클래스 -> 클래스로 복사하는 것
# 자세히 풀면, 기존 클래스의 모든 것을 가져다가 사용하는 것 -> 재사용 or 확장
# 표현: class 클래스명( 클래스명 ):
class A:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y

    def displayInfo(self):
        print(f'A -> {self.x}, {self.y}')


class B(A):
    def calc(self):
        print(self.x * self.y)

b=B(5,3)
b.displayInfo()
b.calc()

class C(B):
    def add(self):
        print(self.x + self.y)
    # 이 함수는 부모인 B클래스의 calc함수의 리모델링이다.
    # 다른말로, 오버라이딩(overriding)이라 한다.
    def calc(self):
        print(self.x ** self.y)

c = C()
c.calc()
# overload (오버로드): 같은 함수명인데 파라미터가 다르게 들어가는 경우

import time as t
t.sleep(3)
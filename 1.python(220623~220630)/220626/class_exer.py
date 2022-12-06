# 파이썬 다양한 파일 입출력
# csv, json, excel, xml 등을 자유자재로 파이썬으로 다룰 수 있어야 한다.
#
# python Class -> 특정 기능을 하기 위한 변수,함수를 하나로 묶어둔 type
# 특징: 유지, 보수가 쉽다
# 일반 언어의 데이터 저장단위는 byte, but 파이썬의 데이터 저장단위는 class이다.

# 파이썬에서 미리 만들어서 제공하는 클래스: Built-in class
# -> 숫자, 문자 저장할수 있는 클래스
# -> int, float, str, bool, list, tuple, dict, set
num = 12.0
year = 2002
month = 6
# print(num.__sizeof__())

# 내 프로그램(프로젝트)에서 데이터를 표현하는 클래스
# 사용자 정의 클래스
# class 클래스명:
#           변수  -> 클래스가 나타내는 속성
#           메서드 -> 클래스의 기능
# -> 클래스를 생성한 것이지 메모리에 데이터를 저장 X
# 손님: 이름, 전화번호
# 구매한다
class Customer:
    def __init__(self, name):
        self.name = name
    def __str__(self):
        return f"{self.name}"


cus1 = Customer("손님1")
cus2 = Customer("손님2")
print(cus1)
print(cus2)

# 계산기 프로그램을 만들고자 함
# -> 계산기 데이터 타입 생성
#    -> 연산(사칙연산) ---> 함수
#    -> 데이터        ---> 변수
# -> 클래스명 <- 어떤 데이터가 저장되는지 알 수 있도록 명명 calc
# -> 변수 num1, num2
# -> 함수(메서드) plus(), minus(), mult(), div()
# 사람을 저장하는 데이터 타입
# 성별, 이름, 나이, 직업, 키, 몸무게, 혈액형  -> 변수
# 먹는다, 잔다, 논다, 일한다, 공부한다  -> 함수
class Calc:

    # 객체 생성자(Constructor)
    # 클래스명() -> 객체 생성 시 호출되는 메서드
    # 파이썬에서 클래스 생성 시에 자주 사용되는 기능의 메서드를 미리 만들어서 제공하는 것
    # 형태 def __메서드명__(self)
    # __init__() : 객체 생성 시 변수 초기화 하는 경우 사용
    def __init__(self, num1=0, num2=0):
        print('__init__')   # 클래스 명을 부르면 __init__가 실행!
        self.num1 = num1
        self.num2 = num2
    # 클래스의 기능 -> 메서드
    def plus(self, num1, num2):
        print(self.num1 + self.num2)
        print(num1 + num2)
    def minus(self, num1, num2):
        print(num1 - num2)
    def mult(self, num1, num2):
        print(num1 * num2)
    def div(self, num1, num2):
        print(num1 / num2)




# 클래스 사용하기 --> 메모리에 데이터를 저장 -> 힙에 객체 생성
#              --> 클래스명()  -> 객체 주소
myCalc = Calc(4,7)
yourCalc = Calc(20,5)
otherCalc = Calc()
print(f'{type(myCalc)}')

# 클래스 안에 존재하는 변수, 함수 접근 --> 객체변수명.변수 , 객체변수명.함수명()
myCalc.num1 = 12
myCalc.num2 = 5
myCalc.minus(5,7)
myCalc.plus(4,5)

yourCalc.num1 = 7
yourCalc.num2 = 4
yourCalc.plus(3,5)
yourCalc.div(3,9)
otherCalc.mult(5,6)

myCalc.__init__()
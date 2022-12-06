# 가변인자 함수(variable argument): 인자 개수가 미정인 경우에 유용히 사용 가능
# 유사하거나 동일한 코드 부분이 반복
# 인자 개수만 계속 변경 -> 유동적으로 받자!
# *매개변수 -> 0개~N개 인자 사용, tuple타입
def addSome(*args):
    print(type(args))
    value = 0
    for i in args: value += i
    return value

print(addSome(4,3,5,2,7,11))
print(addSome())

# 키워드 파라미터(keyword parameter)-> dict type
# 기능: 평균 구하는 함수
# 함수명: getAvg
# 파라미터: 과목명 - 점수 유동적 -> **subj
# 반환값: 평균 -> float
def getAvg(**subj):
    print(type(subj))
    values = subj.values()
    total = 0
    for value in values:
        total += value
    return total / len(values) if len(values) >0 else None
b= getAvg(국어=12, 수학=20, 영어=25)  #호출할때 key에서 ''나 ""는 쓰지 않는다, 숫자키도 작동 안됨
print(b)
print(getAvg())


# 매개변수에 초깃값 미리 설정하기

def say_myself(name, old, man=True):
    print(f"내 이름은 {name} 입니다")
    print(f"내 나이는 {old} 입니다")
    if man:
        print("남자입니다")
    else:
        print("남자가 아닙니다")


# 함수(ft)의 데이터 타입 -> class function
print(type(addSome), id(addSome)) # id를 이용하면 함수가 저장된 메모리의 주소를 알 수 있다.

list = [addSome, getAvg]  #함수명을 리스트나 다른 곳에 담아서 쓰는 경우들이 있다.
print(list[0](1,2,3))
print(list[1](국어=33))

# lambda (람다, 익명함수, 라인함수)
# 변수명 = lambda 인수1, 인수2, ... : 실행코드 (리턴값)

cal = [lambda x,y:x+y, lambda x,y: x-y, lambda x,y: x/y]
print(cal[0](1,2))
print(cal[1](1,2))
print(cal[2](1,2))

# 지역변수, 전역변수 -> ok


# test
def add_mul(choice, *args):
    '''
    임의의 개수의 더하기와 곱하기 설정
    :param choice: 'add' or 'mul'
    :param args: 여러개의 int
    :return: int
    '''
    if choice == 'add':
        result = 0
        for i in args:
            result += i
    elif choice == 'mul':
        result = 1
        for i in args:
            result *= i
    return result
print(add_mul('add', 1,2,3,4,5,6))
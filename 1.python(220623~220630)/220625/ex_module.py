# 모듈(Module): 하나의 파이썬(.py)파일, 특정 목적에 관련된 변수, 함수, 클래스 존재
# 필요한 파일에서 사용가능함
# 사용법 -> import 모듈명

# 모듈 포함하기
# import math as m
# from math import factorial as fac

# 모듈 안에 기능 사용하기
# print(m.fabs(-4))
# from math import *
# def factorial(num):
#     print(f'My factorial {num}')
#
# factorial(7)

YEAR = 2022
def printYear():
    print(f'올해는 {YEAR}')


if __name__ == '__main__':
    printYear()
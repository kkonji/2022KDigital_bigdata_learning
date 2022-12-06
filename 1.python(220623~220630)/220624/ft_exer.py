#  함수(function): 자주 사용되는 기능을 묶어서 이름을 붙여 놓은 것
#  - 코드 재사용 위한 것
#  형태
#  def 함수명(재료, ..., 재료n):
#      코드
#      코드
#      return 결과
# ------------------------------------------------------------------

#  기능: 숫자 2개 더한 후, 결과 돌려주는 기능
#  자주 사용하는 기능만 함수로 만들어주면 된다.

#  함수 정의
def addTwo(num1, num2):
    '''
    숫자 2개 더한 후 결과 반환
    :param num1: int
    :param num2: int
    :return: int
    '''
    return num1 + num2

#  함수 사용 (함수 호출)
result = addTwo(4,10)

#  화면에 출력하기 -> print(데이터)
print(addTwo(2, 6))

# exer
# 기능: 문자 2개 더하는 기능의 함수
# 함수명: addStr
# 재료: str 2개    선생님예시: data1  data2
# 반환: str        선생님예시: 더한 결과

def addStr(str1, str2):
    return str1 + str2

print(addStr('a','b'))

# 기능: 원하는 단의 구구단을 출력하는 기능의 함수
# 함수명: gugudan
# 재료: int
# 반환: None
def gugudan(num):
    for i in range(1, 10):
        print("{}*{}={} ".format(num, i, num*i), end="")
  

gugudan(9)





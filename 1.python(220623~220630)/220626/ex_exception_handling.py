# exception handling: 예외처리
# 프로그램 실행 시 발생하는 오류에 대한 처리
# 오류가 발생해도 프로그램 중단하지 않고 실행될 수 있도록 하는 것.

try:
    num1 , num2 = 10, 0
    print(f'{num1/num2}')
except Exception as ep:  # 모르는 에러의 경우 Exception으로 쓰면 된다.
    print("에러발생", ep)

finally:
    pass
# 오류 발생 여부 상관없음
# 무조건 실행
print("end")

try:
    file = open('agara.jpg', mode='r', encoding='utf-8')
    print(file.read())
    file.close()
except FileNotFoundError as e:
    print(f'error발생: {e}')

import os.path
if os.path.exists('agara.jpg'):
    file = open('agara.jpg', mode='r', encoding='utf-8')
    print(file.read())
    file.close()
else:
    print("없는 파일")


# 오류 일부러 발생시키기 -> 강제로 무언가를 하게 만들때 필요
# x = int(input("3의 배수를 입력하세요: "))
# try:
#     if x % 3 != 0:
#         raise Exception('3의 배수가 아닙니다.')
#     print(x)
# except Exception as e:
#     print(e)

# 예시 2

# class Bird:
#     def fly(self):
#         raise NotImplementedError
#
# class Eagle(Bird):
#     pass
#
# eagle = Eagle()
# eagle.fly()

# 비밀번호 입력
def password():
    t, pw = 5, 1567
    while t >0:
        print(f'비밀번호를 입력하세요, {t}')
        num = int(input("패스워드4글자: "))
        try:
            if num == pw:
                print("비밀번호가 맞습니다.")
                break
            else:
                t -= 1
                raise Exception("비밀번호가 틀렸습니다.")

        except Exception as e:
            print(e)
    if t==0: print("비밀번호가 잠겼습니다. 관리자에게 문의하세요")
password()
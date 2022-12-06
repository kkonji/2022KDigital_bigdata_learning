A = 'lateral'
B = " ".join(A).split()
B[1] = 'i'
C = "".join(B)
print(C)

dict = {
    "국어": 80,
    "영어": 75,
    "수학": 55
}
# 연습문제 1
d = dict["국어"]
total = 0
count = 0
for key, value in dict.items():
    total += value
    count += 1
average = total / count
print(average)

# 연습문제 2
def odd_even(num):
    if num % 2 == 0:
        print(f'{num}는 짝수')
    else:
        print(f'{num}는 홀수')

odd_even(13)

# 연습문제 3
def joomin(pin):
    if int(pin[:2]) > 22:
        yyyymmdd = "19" + pin[:6]
    else:
        yyyymmdd = "20" + pin[:6]
    num = pin[7:]
    print(yyyymmdd)
    print(num)
joomin('941003-2384934')

try:
    4 / 0
except ZeroDivisionError as e:
    print(e)

try:
    with open("dfsf.txt", mode='r', encoding='utf-8') as f:
        print(f.read())
except FileNotFoundError as g:
    print(g)
# 리스트 뒤집는 함수 연습
A = [1,2,3,4,5,6,7,8]

def flip(some_list):
    if len(some_list) == 1:
        return some_list
    else:
        B = flip(some_list[:-1])
        B.insert(0, some_list[-1])
        return B


print(flip(A))



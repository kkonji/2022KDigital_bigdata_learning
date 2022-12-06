# 계산기 관련 숙제

def plus(self, *data):
    result = 0
    if type(self.data) == int or type(self.data) == float:
        for i in data:
            result += i
        self.data = self.data + result
    else:
        for j in self.data:
            result += j
        for i in data:
            result += i
        self.data = result
# def arithmeticFt(num):
#     arithmetic = ['+', '-', 'x', '/']
#     result = 0
#     if type(self.data) == int or type(self.data) == float:
#         for i in data:
#             result += i
#         self.data = self.data + result
#     else:
#         for j in self.data:
#             result += j
#         for i in data:
#             result += i
#         self.data = result


B = eval('sum([4,7])')
print(B)
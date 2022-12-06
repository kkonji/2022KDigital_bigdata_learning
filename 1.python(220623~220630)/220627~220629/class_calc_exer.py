# 계산기 프로그램 (내가 만든 class)
class Ca:
    # 인스턴스 생성자: # 색상, 제조사, 데이터
    def __init__(self, color, brand, *data):
        self.color = color
        self.brand = brand
        self.data = data
    # getter, setter 메서드는 선택
    def getData(self): return self.data
    def setData(self, *data): self.data = data
    # 내가 원하는 계산기 기능
    def plus(self, *data):
        pass
    def showUI(self):
        print("***** 계산기 *****")
        print("1. 덧셈")
        print("2. 뺄셈")
        print("3. 곱셈")
        print("4. 나눗셈")
        print("Q. 나가기")
        print("*****************")
def getNumbers(self):
    nums = []
    while True:
        num = input("계산할 숫자 입력(q,Q로 탈출): ")
        if num in ['q', 'Q']: break
        nums.append(int(num))
    return nums
def calPlay():
    calcApp = Ca('shap', 'pink')
    while True:
        calcApp.showUI()
        select =input("선택하라: ")
        if select == 'Q':
            break
        elif select == '1':
            calcApp.setData(getNumbers())
            print(f'덧셈 결과: {calcApp.plus()}')


calPlay()